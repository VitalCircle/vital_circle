import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:vital_circle/constants/analytics_event.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/enums/auth_provider_type.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/services/auth/anonymous_auth.service.dart';
import 'package:vital_circle/services/local_storage.service.dart';
import 'package:vital_circle/services/log/log.service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'auth_provider_type_cache.dart';
import 'google_auth.service.dart';

abstract class AuthProviderService {
  Future<bool> signIn();
  Future<bool> signInSilently();
  Future signOut();
}

/// High level facade for interfacing with the various authentication providers.
class AuthService {
  AuthService(this._localStorage, GoogleAuthService googleAuthService, AnonymousAuthService anonymousAuthService) {
    _authTypeCache = AuthProviderTypeCache(_localStorage);
    _authProviderServices[AuthProviderType.google] = googleAuthService;
    _authProviderServices[AuthProviderType.anonymous] = anonymousAuthService;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  final _log = LogService.zone(LogZone.AUTH);
  final _authProviderServices = <AuthProviderType, AuthProviderService>{};
  final LocalStorage _localStorage;
  AuthProviderTypeCache _authTypeCache;

  Future<FirebaseUser> get user async {
    return await _firebaseAuth.currentUser();
  }

  Future<bool> get isAuthenticated async => (await user) != null;

  /// Attempt to sign in without interacting with the user.
  /// Will not throw an exception.
  Future<bool> signInSilently() async {
    final AuthProviderType authType = await _authTypeCache.getAuthProviderType();
    if (authType == null) {
      _log.trace('Silent sign in failed because no auth provider type is specified.');
      return false;
    }
    final AuthProviderService authProvider = _authProviderServices[authType];
    final bool didSignIn = await authProvider.signInSilently();
    if (didSignIn) {
      await _initCrashlyticsUserContext();
    }
    _log.trace(
        'Silent SignIn ${didSignIn ? 'Succeeded' : 'Failed'}.', <String, String>{'authType': authType.toString()});
    return didSignIn;
  }

  /// Attempt to authenticate the user.
  /// Return false if the user abandoned the process or true if it succeeded.
  /// Throws exceptions for failures.
  Future<bool> socialSignIn(AuthProviderType authType) async {
    _log.trace('Attempt sign-in', <String, String>{'authType': authType.toString()});
    final AuthProviderService authProvider = _authProviderServices[authType];
    if (!await authProvider.signIn()) {
      _analytics
          .logEvent(name: AnalyticsEvent.ABANDONED_SIGN_IN, parameters: <String, dynamic>{'type': authType.toString()});
      _log.trace('SignIn abandoned.', <String, String>{'authType': authType.toString()});
      return false;
    }
    await _initCrashlyticsUserContext();
    await _registerSignIn(authType);
    return true;
  }

  Future _registerSignIn(AuthProviderType authType) async {
    await _authTypeCache.setAuthProviderType(authType);
    _analytics.logLogin(loginMethod: authType.toString());
    _log.trace('SignIn succeeded.', <String, String>{'authType': authType.toString()});
  }

  Future signOut(BuildContext context) async {
    final AuthProviderType authType = await _authTypeCache.getAuthProviderType();
    if (authType == null) {
      _log.trace('SignOut abandoned because no auth provider type is specified.');
      return;
    }
    await _authProviderServices[authType].signOut();
    await _authTypeCache.removeAuthProviderType();
    _clearCrashlyticsUserContext();
    _analytics.logEvent(name: AnalyticsEvent.SIGN_OUT, parameters: <String, dynamic>{'type': authType.toString()});
    Navigator.pushNamedAndRemoveUntil(context, RouteName.Welcome, (_) => false);
    _log.trace('SignOut succeeded.', <String, String>{'authType': authType.toString()});
  }

  Future _initCrashlyticsUserContext() async {
    _log.trace('Initializing Carshlytics context.');
    final firebaseUser = await user;
    Crashlytics.instance.setUserIdentifier(firebaseUser.uid);
  }

  void _clearCrashlyticsUserContext() {
    _log.trace('Clearing Carshlytics context.');
    Crashlytics.instance.setUserIdentifier(null);
  }
}

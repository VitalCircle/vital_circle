import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teamtemp/constants/analytics_event.dart';
import 'package:teamtemp/constants/log_zone.dart';

import 'log/log.service.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile'], hostedDomain: '', clientId: '');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _log = LogService.zone(LogZone.AUTH);
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  Future<FirebaseUser> get user async {
    return await _firebaseAuth.currentUser();
  }

  Future<bool> signInSilently() async {
    final bool didSignIn = await _signIn(true);
    if (didSignIn) {
      await _initCrashlyticsUserContext();
    }
    _log.trace('Silent SignIn ${didSignIn ? 'Succeeded' : 'Failed'}.');
    return didSignIn;
  }

  Future<bool> signIn() async {
    _log.trace('Attempt sign-in');
    if (!await _signIn(false)) {
      _analytics.logEvent(name: AnalyticsEvent.ABANDONED_SIGN_IN, parameters: <String, dynamic>{'type': 'Google'});
      _log.trace('SignIn abandoned.');
      return false;
    }
    await _initCrashlyticsUserContext();
    _log.trace('SignIn succeeded.');
    return true;
  }

  Future signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    _analytics.logEvent(name: AnalyticsEvent.SIGN_OUT, parameters: <String, dynamic>{'type': 'Google'});
    _log.trace('SignOut succeeded.');
  }

  Future<bool> _signIn([bool isSilent = false]) async {
    GoogleSignInAccount googleUser = _googleSignIn.currentUser;
    googleUser ??= await (isSilent ? _googleSignIn.signInSilently() : _googleSignIn.signIn());
    if (googleUser == null) {
      return false;
    }
    return await _signInWithFirebase(googleUser);
  }

  Future<bool> _signInWithFirebase(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication auth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return authResult != null;
  }

  Future _initCrashlyticsUserContext() async {
    _log.trace('Initializing Carshlytics context.');
    final firebaseUser = await user;
    Crashlytics.instance.setUserIdentifier(firebaseUser.uid);
    Crashlytics.instance.setUserEmail(firebaseUser.email);
    Crashlytics.instance.setUserName(firebaseUser.displayName);
  }
}

import 'package:flutter/material.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/services/auth/auth.service.dart';
import 'package:vital_circle/services/firestore/user.api.dart';
import 'package:vital_circle/services/log/log.service.dart';

class StartUpService {
  StartUpService(this._authService, this._userApi);

  final AuthService _authService;
  final UserApi _userApi;
  final _log = LogService.zone(LogZone.START_UP);

  Future<void> next(BuildContext context) async {
    if (!await _checkAuthentication(context)) {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.Welcome, (_) => false);
      return;
    }

    if (await _requiresOnboarding()) {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.Onboarding, (_) => false);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, RouteName.Dashboard, (_) => false);
  }

  Future<bool> _checkAuthentication(BuildContext context) async {
    if (!await _authService.isAuthenticated) {
      _log.trace('Attempting silent sign-in.');
      final bool isAuthenticated = await _authService.signInSilently();
      if (!isAuthenticated) {
        _log.trace('Not authenticated. Sending to welcome screen to chose to create an account or sign-in.');
        return false;
      }
    }
    _log.trace('User is authenticated.');
    return true;
  }

  Future<bool> _requiresOnboarding() async {
    final fbUser = await _authService.user;
    final user = await _userApi.getUser(fbUser.uid);
    return user == null ||
        user.agreements == null ||
        user.agreements.privacyPolicy == null ||
        user.agreements.termsOfService == null ||
        user.agreements.acceptedLocationSharing == null;
  }
}

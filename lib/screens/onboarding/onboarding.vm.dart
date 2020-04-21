import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:vital_circle/services/services.dart';

import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';

enum OnboardingSteps { PrivacyPolicy, TermsOfService, LocationSharing }

class OnboardingViewModel extends ChangeNotifier {
  OnboardingViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _userApi = Provider.of(context);

  final AuthService _authService;
  final UserApi _userApi;

  bool _isReady = false;
  bool get isReady => _isReady;

  Set<OnboardingSteps> _steps = <OnboardingSteps>{};
  Set<OnboardingSteps> get steps => _steps;

  Future<void> onInit(BuildContext context) async {
    final fbUser = await _authService.user;
    final user = await _userApi.getUser(fbUser.uid);
    _steps = _getSteps(user);
    if (_steps.isEmpty) {
      await onDone(context);
    }
    _isReady = true;
    notifyListeners();
  }

  Future<void> onDone(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, RouteName.Dashboard);
  }

  Set<OnboardingSteps> _getSteps(User user) {
    final steps = <OnboardingSteps>{};
    if (user == null || user.agreements == null || user.agreements.privacyPolicy == null) {
      steps.add(OnboardingSteps.PrivacyPolicy);
    }
    if (user == null || user.agreements == null || user.agreements.termsOfService == null) {
      steps.add(OnboardingSteps.TermsOfService);
    }
    /*
    if (user == null ||
        user.agreements == null ||
        user.agreements.locationSharing == null) {
      steps.add(OnboardingSteps.LocationSharing);
    }
    */
    return steps;
  }
}

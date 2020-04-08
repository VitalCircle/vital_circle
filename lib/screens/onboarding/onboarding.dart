import 'package:flutter/material.dart';
import 'package:teamtemp/screens/onboarding/location-agreement.dart';
import 'package:teamtemp/screens/onboarding/privacy-agreement.dart';
import 'package:teamtemp/screens/onboarding/tos-agreement.dart';
import 'package:teamtemp/shared/shared.dart';

import 'onboarding.vm.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.easeInOut;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OnboardingViewModel>(
      model: OnboardingViewModel.of(context),
      onModelReady: (model) {
        model.onInit(context);
      },
      builder: (context, model, child) {
        return _buildScreen(context);
      },
    );
  }

  Widget _buildScreen(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.page.round() == _pageController.initialPage) {
          return true;
        }
        _previous();
        return false;
      },
      child: PageView(
        controller: _pageController,
        children: <Widget>[
          TermsOfServiceAgreementScreen(onNext: _next),
          PrivacyAgreementScreen(onNext: _next),
          LocationAgreementScreen(onNext: _next),
        ],
      ),
    );
  }

  Future<void> _previous() async {
    await _pageController.previousPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  Future<void> _next() async {
    await _pageController.nextPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

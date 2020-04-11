import 'package:flutter/material.dart';
import 'package:vital_circle/screens/onboarding/location-agreement.dart';
import 'package:vital_circle/screens/onboarding/privacy-agreement.dart';
import 'package:vital_circle/screens/onboarding/tos-agreement.dart';
import 'package:vital_circle/shared/shared.dart';

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
        return model.isReady ? _buildScreen(context, model) : _buildLoader();
      },
    );
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, OnboardingViewModel model) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.page.round() == _pageController.initialPage) {
          return true;
        }
        _toPrevious();
        return false;
      },
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          if (model.steps.contains(OnboardingSteps.PrivacyPolicy)) PrivacyAgreementScreen(onNext: () => _toNext(model)),
          if (model.steps.contains(OnboardingSteps.TermsOfService))
            TermsOfServiceAgreementScreen(onNext: () => _toNext(model)),
          if (model.steps.contains(OnboardingSteps.LocationSharing))
            LocationAgreementScreen(onNext: () => _toNext(model)),
        ],
      ),
    );
  }

  Future<void> _toPrevious() async {
    await _pageController.previousPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  Future<void> _toNext(OnboardingViewModel model) async {
    if (_pageController.page == model.steps.length - 1) {
      await model.onDone(context);
      return;
    }
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

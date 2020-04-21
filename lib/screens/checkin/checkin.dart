import 'package:flutter/material.dart';
import 'package:vital_circle/screens/checkin/checkin_feeling.dart';
import 'package:vital_circle/screens/checkin/checkin_review.dart';
import 'package:vital_circle/screens/checkin/checkin_symptoms.dart';
import 'package:vital_circle/screens/checkin/checkin_temperature.dart';
import 'package:vital_circle/shared/shared.dart';

import 'checkin.vm.dart';

class CheckinScreen extends StatefulWidget {
  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.easeInOut;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckinViewModel>(
        model: CheckinViewModel.of(context),
        onModelReady: (model) => model.init(context),
        builder: (context, model, child) {
          return _buildScreen(context, model);
        });
  }

  Widget _buildScreen(BuildContext context, CheckinViewModel model) {
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
        children: [
          CheckinFeeling(onNext: () => _toNext(model), model: model),
          CheckinTemperature(onNext: () => _toNext(model), onPrevious: () => _toPrevious(), model: model),
          CheckinSymptoms(onNext: () => _toNext(model), onPrevious: () => _toPrevious(), model: model),
          CheckinReview(onNext: () => _toNext(model), onPrevious: () => _toPrevious(), model: model),
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

  Future<void> _toNext(CheckinViewModel model) async {
    if (_pageController.page == model.steps.length - 1) {
      await model.submit(context);
      // Navigator.popAndPushNamed(context, '/checkin_done');
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

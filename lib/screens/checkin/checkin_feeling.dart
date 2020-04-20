import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/shared/checkin/checkin_header.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/themes/spacers.dart';

import 'checkin.vm.dart';

class CheckinFeeling extends StatelessWidget {
  CheckinFeeling({@required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckinViewModel>(
      model: CheckinViewModel.of(context),
      builder: (context, model, child) {
        return _buildScreen(context, model);
      },
    );
  }

  Widget _buildScreen(BuildContext context, CheckinViewModel model) {
    return Scaffold(
      appBar: SharedAppBar(
        title: const Text('Check-in'),
        // empty container used to hide back button
        leading: Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName(RouteName.Dashboard)))
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Spacers.md, vertical: Spacers.md),
                  children: <Widget>[
                    checkinHeader(
                        context,
                        model,
                        'How are you feeling today?', //todo: extract prior day's symptoms
                        'Yesterday, you felt worse'),
                    _buildItem(context, model, FeelingOption.BETTER),
                    _buildItem(context, model, FeelingOption.SIMILAR),
                    _buildItem(context, model, FeelingOption.WORSE),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Spacers.md, vertical: Spacers.lg),
                child: SizedBox(
                  width: double.infinity,
                  child: ProgressButton(
                      label: 'Continue',
                      onPressed: () => _continue(context, model),
                      type: ProgressButtonType.Raised),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, CheckinViewModel model, String option) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: SelectionCard(
          title: option,
          selected: model.feeling == option,
        ),
        onTap: () => model.selectFeeling(option),
      ),
    );
  }

  void _continue(BuildContext context, CheckinViewModel model) {
    // dismiss keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    onNext();
    // todo: implement checkin.onNext
  }
}

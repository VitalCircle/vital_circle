import 'package:flutter/material.dart';
import 'package:vital_circle/shared/checkin/checkin_header.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/themes/spacers.dart';

import 'checkin.vm.dart';

class CheckinFeeling extends StatelessWidget {
  CheckinFeeling({@required this.onNext});

  final VoidCallback onNext;

  final List<String> feeling = [
    'Better than ever!',
    'Pretty similar to yesterday.',
    'Worse than yesterday.'
  ];

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
                    _buildItem(context, model, 0),
                    _buildItem(context, model, 1),
                    _buildItem(context, model, 2),
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

  Widget _buildItem(BuildContext context, CheckinViewModel model, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: SelectionCard(
          title: feeling[index],
          selected: false,
        ),
        onTap: () {
          //todo: toggle selected
        },
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

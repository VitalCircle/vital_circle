import 'package:flutter/material.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';
import 'package:vital_circle/routes.dart';

import '../../themes/spacers.dart';
import 'checkin.vm.dart';

class CheckinFeeling extends StatefulWidget {
  @override
  _CheckinFeelingState createState() => _CheckinFeelingState();
}

class _CheckinFeelingState extends State<CheckinFeeling>
    with AutomaticKeepAliveClientMixin {
  //todo: extract into data model
  List<String> feeling = [
    'Better than ever!',
    'Pretty similar to yesterday.',
    'Worse than yesterday.'
  ];
  List<bool> feelingCheck = [false, false, false];

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
                    _buildHeader(context, model),
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

  Widget _buildHeader(BuildContext context, CheckinViewModel model) {
    return Column(children: [
      Text('How are you feeling today?', style: AppTypography.h2),
      const SizedBox(height: Spacers.sm),
      Text(
        //todo: extract prior day's symptoms. adjust padding
        'Yesterday, you felt worse',
        style: AppTypography.bodyRegular1,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: Spacers.lg),
    ]);
  }

  Widget _buildItem(BuildContext context, CheckinViewModel model, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: SelectionCard(
          title: feeling[index],
          selected: feelingCheck[index],
        ),
        onTap: () => setState(
          () {
            // todo: extract into viewmodel
            feelingCheck[index] = !feelingCheck[index];
          },
        ),
      ),
    );
  }

  void _continue(BuildContext context, CheckinViewModel model) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    // todo: implement checkin.onNext
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:vital_circle/shared/checkin/checkin_header.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';
import 'package:vital_circle/routes.dart';

import 'checkin.vm.dart';

class CheckinTemperature extends StatelessWidget {
  final List<String> subjectiveTemp = ['Feeling hot', 'Feeling fine', 'Unsure'];

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
        leading: BackButton(
          onPressed: () {
            // todo: implement checkin.onPrevious
          },
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: Spacers.md),
                child: checkinHeader(
                    context,
                    model,
                    'What is your temperature?',
                    'Yesterday, you recorded 100.4 °F'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
                child: _buildTemp(context, model),
              ),
              _buildSubjectiveTemp(context, model),
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
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CheckinViewModel model) {
    return Column(children: [
      Text('What is your temperature?', style: AppTypography.h2),
      const SizedBox(height: Spacers.sm),
      Text(
        //todo: extract prior day's symptoms. adjust padding
        'Yesterday, you recorded 100.4 °F',
        style: AppTypography.bodyRegular1,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: Spacers.lg),
    ]);
  }

  Widget _buildTemp(BuildContext context, CheckinViewModel model) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Temperature',
        border: OutlineInputBorder(),
        suffix: Text('°F'),
      ),
      keyboardType: TextInputType.number,
      initialValue: '',
      onSaved: (value) {
        model.temperature = double.tryParse(value);
      },
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildSubjectiveTemp(BuildContext context, CheckinViewModel model) {
    return Column(
      children: <Widget>[
        const Text('No thermometer?'),
        const SizedBox(height: Spacers.sm),
        Wrap(
          // crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: <Widget>[
            _buildItem(context, model, 0),
            _buildItem(context, model, 1),
            _buildItem(context, model, 2),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, CheckinViewModel model, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: SelectionCardSmall(
          title: subjectiveTemp[index],
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
    FocusScope.of(context).requestFocus(FocusNode());
    model.submit(context);
  }
}

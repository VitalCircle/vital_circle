import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/shared/checkin/checkin_header.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/routes.dart';

import 'checkin.vm.dart';

class CheckinTemperature extends StatelessWidget {
  const CheckinTemperature({@required this.onNext, @required this.onPrevious, @required this.model});

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final CheckinViewModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        title: const Text('Check-in'),
        leading: BackButton(
          onPressed: () => onPrevious(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(RouteName.Dashboard)))
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
                child: checkinHeader(context, model, 'What is your temperature?', 'Yesterday, you recorded 100.4 °F'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
                child: _buildTemp(context, model),
              ),
              _buildSubjectiveTemp(context, model),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacers.md, vertical: Spacers.lg),
                child: SizedBox(
                  width: double.infinity,
                  child: ProgressButton(
                      label: 'Continue', onPressed: () => _continue(context), type: ProgressButtonType.Raised),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildTemp(BuildContext context, CheckinViewModel model) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Temperature',
        border: OutlineInputBorder(),
        suffix: Text('°F'),
      ),
      keyboardType: TextInputType.number,
      initialValue: model.temperature?.toString() ?? '',
      onChanged: (value) {
        model.subjectiveTemp = null;
        model.temperature = double.tryParse(value);
      },
      onFieldSubmitted: (value) {
        _continue(context);
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
            _buildItem(context, model, SubjectiveTempOption.HOT),
            _buildItem(context, model, SubjectiveTempOption.FINE),
            _buildItem(context, model, SubjectiveTempOption.UNSURE),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, CheckinViewModel model, String option) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          child: SelectionCardSmall(
            title: option,
            selected: model.subjectiveTemp == option,
          ),
          onTap: () {
            model.selectSubjectiveTemp(option);
            model.temperature = null;
            _continue(context);
          }),
    );
  }

  void _continue(BuildContext context) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    onNext();
  }
}

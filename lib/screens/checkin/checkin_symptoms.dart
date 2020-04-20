import 'package:flutter/material.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/checkin/checkin_header.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/utils/symptom_label.dart';

import 'checkin.vm.dart';

class CheckinSymptoms extends StatelessWidget {
  const CheckinSymptoms({@required this.onNext, @required this.onPrevious});

  final VoidCallback onNext;
  final VoidCallback onPrevious;

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
          onPressed: () => onPrevious(),
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
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Spacers.md, vertical: Spacers.md),
                  children: <Widget>[
                    checkinHeader(
                        context,
                        model,
                        'Please select your symptoms',
                        // todo: extract symptoms
                        'Yesterday, you had cough, short of breath, and body aches'),
                    ...Symptom.values
                        .map((s) => _buildSymptom(context, model, s))
                        .toList(),
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
                      onPressed: () {
                        _submit(context, model);
                      },
                      type: ProgressButtonType.Raised),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void _submit(BuildContext context, CheckinViewModel model) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    onNext();
  }

  Widget _buildSymptom(
      BuildContext context, CheckinViewModel model, Symptom symptom) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: SelectionCard(
          title: symptomLabelMap[symptom],
          selected: model.selectedSymptoms.contains(symptom),
        ),
        onTap: () => model.toggleSymptom(symptom),
      ),
    );
  }
}

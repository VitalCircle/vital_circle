import 'package:flutter/material.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';
import 'package:vital_circle/utils/symptom_label.dart';

import 'checkin.vm.dart';

class CheckinScreen extends StatefulWidget {
  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
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
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    _buildTemp(context, model),
                    const SizedBox(height: Spacers.xl),
                    _buildSymptoms(context, model),
                    const Spacer(flex: 1),
                    SizedBox(
                      width: double.infinity,
                      child: ProgressButton(
                          label: 'Submit',
                          onPressed: () {
                            _submit(context, model);
                          },
                          type: ProgressButtonType.Raised),
                    )
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              padding: const EdgeInsets.all(16),
            ),
          );
        }));
  }

  void _submit(BuildContext context, CheckinViewModel model) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    model.submit(context);
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

  Widget _buildSymptoms(BuildContext context, CheckinViewModel model) {
    return Column(children: [
      Text('Symptoms', style: AppTypography.h2),
      Text(
        'Please select the symptoms that you are experiencing:',
        style: AppTypography.bodyBold,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: Spacers.md),
      Wrap(
        children: Symptom.values.map((s) => _buildSymptom(context, model, s)).toList(),
        runSpacing: 0,
        spacing: 12,
      ),
    ]);
  }

  Widget _buildSymptom(BuildContext context, CheckinViewModel model, Symptom symptom) {
    return ChoiceChip(
      label: Text(symptomLabelMap[symptom]),
      onSelected: (selected) {
        model.toggleSelected(symptom);
      },
      selected: model.selectedSymptoms.contains(symptom),
    );
  }
}

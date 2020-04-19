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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            children: <Widget>[
              _buildTemp(context, model),
              const SizedBox(height: Spacers.xl),
              _buildSymptomTitle(context, model),
              ...Symptom.values
                  .map((s) => _buildSymptom(context, model, s))
                  .toList(),
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
          );
        },
      ),
    );
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

  Widget _buildSymptomTitle(BuildContext context, CheckinViewModel model) {
    return Column(children: [
      Text('Please select your symptoms', style: AppTypography.h2),
      Text(
        //todo: extract prior day's symptoms. adjust padding
        'Yesterday, you had cough, short of breath,\n and body aches',
        style: AppTypography.bodyRegular1,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: Spacers.lg),
    ]);
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
        onTap: () => model.toggleSelected(symptom),
      ),
    );
  }
}

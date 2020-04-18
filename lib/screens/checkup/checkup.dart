import 'package:flutter/material.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/utils/symptom_label.dart';

import 'checkup.vm.dart';

class CheckupScreen extends StatefulWidget {
  @override
  _CheckupScreenState createState() => _CheckupScreenState();
}

class _CheckupScreenState extends State<CheckupScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckupViewModel>(
      model: CheckupViewModel.of(context),
      builder: (context, model, child) {
        return _buildScreen(context, model);
      },
    );
  }

  Widget _buildScreen(BuildContext context, CheckupViewModel model) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('How\'s Your Health?'),
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
                      child: RaisedButton(
                        child: const Text('Submit'),
                        color: AppColors.buttonBackground,
                        onPressed: () {
                          _submit(context, model);
                        },
                      ),
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

  void _submit(BuildContext context, CheckupViewModel model) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    model.submit(context);
  }

  Widget _buildTemp(BuildContext context, CheckupViewModel model) {
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

  Widget _buildSymptoms(BuildContext context, CheckupViewModel model) {
    return Column(children: [
      Text(
        'Symptoms',
        style: Theme.of(context).textTheme.headline,
      ),
      Text(
        'Please select the symptoms that you are experiencing:',
        style: Theme.of(context).textTheme.subhead,
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

  Widget _buildSymptom(BuildContext context, CheckupViewModel model, Symptom symptom) {
    return ChoiceChip(
      label: Text(symptomLabelMap[symptom]),
      onSelected: (selected) {
        model.toggleSelected(symptom);
      },
      selected: model.selectedSymptoms.contains(symptom),
    );
  }
}

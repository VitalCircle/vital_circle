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
      body: Column(
        children: <Widget>[
          _buildTemp(context, model),
          const SizedBox(height: Spacers.lg),
          Expanded(
            child: _buildSymptoms(context, model),
          ),
          RaisedButton(
            child: const Text('Submit'),
            onPressed: () {
              _submit(context, model);
            },
          )
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  void _submit(BuildContext context, CheckupViewModel model) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    model.submit(context);
  }

  Widget _buildTemp(BuildContext context, CheckupViewModel model) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Temperature', hintText: 'Temperature (Fahrenheit)'),
      keyboardType: TextInputType.number,
      initialValue: '',
      onSaved: (value) {
        model.temperature = double.tryParse(value);
      },
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildSymptoms(BuildContext context, CheckupViewModel model) {
    return Wrap(children: Symptom.values.map((s) => _buildSymptom(context, model, s)).toList());
  }

  Widget _buildSymptom(BuildContext context, CheckupViewModel model, Symptom symptom) {
    return ChoiceChip(
      label: Text(symptomLabelMap[symptom]),
      selected: model.selectedSymptoms.contains(symptom),
      onSelected: (selected) {
        model.toggleSelected(symptom);
      },
    );
  }
}

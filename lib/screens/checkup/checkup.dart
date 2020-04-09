import 'package:flutter/material.dart';
import 'package:vital_circle/constants/images.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

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
      onModelReady: (model) {
        model.init();
      },
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
          )
        ],
        mainAxisSize: MainAxisSize.max,
      ),
      endDrawer: DrawerWidget(),

      // Bottom Nav
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: fab(context, Icons.check, () {
        _submit(context, model);
      }),
      bottomNavigationBar: bottomNav(context),
    );
  }

  void _submit(BuildContext context, CheckupViewModel model) {
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    model.submit();
    Navigator.pop(context);
  }

  Widget _buildTemp(BuildContext context, CheckupViewModel model) {
    return TextFormField(
        decoration: const InputDecoration(
            labelText: 'Temperature', hintText: 'Temperature (Fahrenheit)'),
        keyboardType: TextInputType.number,
        initialValue: '',
        onSaved: (value) {
          model.checkup.temp = double.tryParse(value);
        },
        textInputAction: TextInputAction.next);
  }

  Widget _buildSymptoms(BuildContext context, CheckupViewModel model) {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        _buildSymptom(
            context, model, 'Fever', Images.FEVER, model.checkup.febrile,
            (value) {
          model.checkup.febrile = value;
        }),
        _buildSymptom(
            context, model, 'Cough', Images.COUGH, model.checkup.cough,
            (value) {
          model.checkup.cough = value;
        }),
        _buildSymptom(context, model, 'Short of Breath', Images.SHORT_OF_BREATH,
            model.checkup.shortnessOfBreath, (value) {
          model.checkup.shortnessOfBreath = value;
        }),
        _buildSymptom(context, model, 'Feeling Ill', Images.FEELING_ILL,
            model.checkup.feelingIll, (value) {
          model.checkup.feelingIll = value;
        }),
        _buildSymptom(
            context, model, 'Headache', Images.HEADACHE, model.checkup.headache,
            (value) {
          model.checkup.headache = value;
        }),
        _buildSymptom(context, model, 'Body Aches', Images.BODY_ACHES,
            model.checkup.bodyAches, (value) {
          model.checkup.bodyAches = value;
        }),
        _buildSymptom(context, model, 'Weird/No Taste', Images.ODD_TASTE,
            model.checkup.oddTaste, (value) {
          model.checkup.oddTaste = value;
        }),
        _buildSymptom(context, model, 'Weird/No Smell', Images.ODD_SMELL,
            model.checkup.oddSmell, (value) {
          model.checkup.oddSmell = value;
        }),
        _buildSymptom(context, model, 'Sneezing/Runny Nose', Images.SNEEZE,
            model.checkup.sneezingOrRunnyNose, (value) {
          model.checkup.sneezingOrRunnyNose = value;
        }),
        _buildSymptom(context, model, 'Sore Throat', Images.SORE_THROAT,
            model.checkup.soreThroat, (value) {
          model.checkup.soreThroat = value;
        }),
        _buildSymptom(
            context, model, 'Other', Images.OTHER, model.checkup.other,
            (value) {
          model.checkup.other = value;
        }),
      ],
    );
  }

  Widget _buildSymptom(BuildContext context, CheckupViewModel model,
      String label, String image, int value, Function(int) setValue) {
    return InkWell(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final days = await _getSymptomDays(context, value);
        setValue(days);
        model.update();
      },
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          padding: EdgeInsets.all(Spacers.md),
        ),
        color: value > 0
            ? AppColors.buttonColorSelectedBad
            : AppColors.buttonBackground,
      ),
    );
  }

  Future<int> _getSymptomDays(BuildContext context, int value) async {
    return await showDialog<int>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('How Many Days?'),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 230,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(Spacers.lg),
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: [
                        _buildDay(context, 'One', 1, value),
                        _buildDay(context, 'Two', 2, value),
                        _buildDay(context, 'Three', 3, value),
                        _buildDay(context, 'Four', 4, value),
                        _buildDay(context, 'Five', 5, value),
                        _buildDay(context, 'Six', 6, value),
                      ],
                    ),
                  ),
                ],
              );
            }) ??
        0;
  }

  Widget _buildDay(
      BuildContext context, String label, int value, int selectedValue) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, value);
      },
      child: Card(
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        color: value == selectedValue
            ? AppColors.buttonColorSelectedBad
            : AppColors.buttonBackground,
      ),
    );
  }
}

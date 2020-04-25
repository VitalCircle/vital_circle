import 'package:flutter/material.dart';
import 'package:vital_circle/enums/subjective_temp.dart';
import 'package:vital_circle/models/icon.model.dart';
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
        title: 'Check-in',
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
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: Spacers.md),
                    child:
                        checkinHeader(context, model, 'What is your temperature?', 'Yesterday, you recorded 100.4 °F'),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Spacers.md),
                      child: _buildTemp(context, model),
                    ),
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemp(BuildContext context, CheckinViewModel model) {
    return TextFormField(
      style: AppTypography.h2,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: 'Temperature',
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
            _buildItem(context, model, SubjectiveTemp.hot),
            _buildItem(context, model, SubjectiveTemp.fine),
            _buildItem(context, model, SubjectiveTemp.unsure),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, CheckinViewModel model, SubjectiveTemp subjectiveTemp) {
    final String option = getSubjectiveTempTitle(subjectiveTemp);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          child: SelectionCardSmall(
            title: option,
            selected: model.subjectiveTemp == option,
            icon: IconProperty().getIconFromTemp(subjectiveTemp),
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

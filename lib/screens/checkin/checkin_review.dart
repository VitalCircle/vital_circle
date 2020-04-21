import 'package:flutter/material.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/checkin/checkin_header.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

import 'checkin.vm.dart';

class CheckinReview extends StatelessWidget {
  const CheckinReview({@required this.onNext, @required this.onPrevious, @required this.model});

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final CheckinViewModel model;

  @override
  Widget build(BuildContext context) {
    final hasData = model.hasData;

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
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: Spacers.md, vertical: Spacers.md),
                  children: <Widget>[
                    checkinHeader(context, model, 'Summary', ''),
                    // if (model.feeling != null)
                    //   _buildReview('Feeling', model.feeling),
                    // _buildDivider(), //todo: show/hide logic
                    // if (model.temperature != null)
                    //   //     || model.subjectiveTemp != null)
                    //   _buildReview('Temperature', '${model.temperature} °F'),
                    // _buildDivider(), //todo: show/hide logic
                    // if (model.selectedSymptoms != null)
                    //   _buildReview(
                    //       'Symptoms', model.selectedSymptoms.toList().map((s) => symptomLabelMap[s]).join(', ')),
                    hasData
                        ? CheckinSummary(checkin: model.getModel)
                        : const Center(child: Text('Please complete your daily check-in'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacers.md, vertical: Spacers.lg),
                child: SizedBox(
                  width: double.infinity,
                  child: ProgressButton(
                      label: 'Submit',
                      onPressed: hasData
                          ? () {
                              _submit(context, model);
                            }
                          : null,
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

  Widget _buildReview(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacers.md, vertical: Spacers.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: AppTypography.h3),
          SizedBox(height: Spacers.sm),
          Text(subtitle),
        ],
      ),
    );
  }

  Widget _buildDivider() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
        child: Divider(thickness: 2.0, color: AppColors.cardBorder),
      );
}

import 'package:flutter/material.dart';
import 'package:vital_circle/extensions/index.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';
import 'package:vital_circle/utils/symptom_label.dart';

class CheckinSummary extends StatelessWidget {
  const CheckinSummary({@required this.checkin}) : assert(checkin != null);

  final Checkin checkin;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    // TODO: map the feeling value to the label
    if (checkin.feeling != null) {
      widgets.add(_buildDetailRow('Feeling', checkin.feeling));
    }

    final temp = checkin.temp != null ? '${checkin.temp} °F' : checkin.subjectiveTemp;
    if (temp != null) {
      widgets.add(_buildDetailRow('Temperature', temp));
    }

    final symptomsSet = checkin.symptoms.toList();
    if (symptomsSet.isNotEmpty) {
      final symptoms = checkin.symptoms.toList().map((s) => symptomLabelMap[s]).join(', ');
      widgets.add(_buildDetailRow('Symptoms', symptoms));
    }

    return Column(
      children: [...widgets.intersperse(const Divider())],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _buildDetailRow(String title, String body) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(title, style: AppTypography.bodyBold),
          Text(body),
          const SizedBox(height: Spacers.md),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: const EdgeInsets.symmetric(vertical: Spacers.md),
    );
  }
}

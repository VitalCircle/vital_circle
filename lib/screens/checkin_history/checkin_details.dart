import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/screens/checkin/checkin.vm.dart';
import 'package:vital_circle/shared/progress_button.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/themes/typography.dart';
import 'package:vital_circle/utils/symptom_label.dart';

class CheckinDetails extends StatelessWidget {
  const CheckinDetails({@required this.checkin, @required this.date});

  final DateTime date;
  final Checkin checkin;

  @override
  Widget build(BuildContext context) {
    return checkin == null ? _buildEmpty(context) : _buildDetails(context);
  }

  Widget _buildEmpty(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ProgressButton(
        feel: ProgressButtonFeel.Secondary,
        label: 'Add record',
        onPressed: () {
          Navigator.of(context).popAndPushNamed(RouteName.Checkin,
              arguments: CheckinScreenRouteData(date, null));
        },
        type: ProgressButtonType.Flat,
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    // TODO: share this view with the summary after creating a checkin
    return Column(
      children: <Widget>[
        // TODO: map the feeling value to the label
        _buildDetailRow('Feeling', checkin.feeling),
        const Divider(),
        // TODO: handle subjective temp
        _buildDetailRow('Temperature', '${checkin.temp} °F'),
        const Divider(),
        _buildDetailRow(
            'Symptoms',
            checkin.symptoms
                .toList()
                .map((s) => symptomLabelMap[s])
                .join(', ')),
        Center(
          child: ProgressButton(
            feel: ProgressButtonFeel.Secondary,
            label: 'Edit record',
            onPressed: () {
              Navigator.of(context).popAndPushNamed(RouteName.Checkin,
                  arguments: CheckinScreenRouteData(null, checkin));
            },
            type: ProgressButtonType.Flat,
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _buildDetailRow(String title, String body) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(title, style: AppTypography.bodyBold),
          Text(body ?? ''),
          const SizedBox(height: Spacers.md),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: const EdgeInsets.symmetric(vertical: Spacers.md),
    );
  }
}

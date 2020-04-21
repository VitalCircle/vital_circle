import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/screens/checkin/checkin.vm.dart';
import 'package:vital_circle/shared/progress_button.dart';
import 'package:vital_circle/shared/shared.dart';

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
          Navigator.of(context).popAndPushNamed(RouteName.Checkin, arguments: CheckinScreenRouteData(date, null));
        },
        type: ProgressButtonType.Flat,
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckinSummary(checkin: checkin),
        Center(
          child: ProgressButton(
            feel: ProgressButtonFeel.Secondary,
            label: 'Edit record',
            onPressed: () {
              Navigator.of(context)
                  .popAndPushNamed(RouteName.Checkin, arguments: CheckinScreenRouteData(null, checkin));
            },
            type: ProgressButtonType.Flat,
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

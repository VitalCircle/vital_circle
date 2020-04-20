import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/utils/symptom_label.dart';

class CheckinListScreen extends StatelessWidget {
  const CheckinListScreen({@required List<Checkin> checkins})
      : _checkins = checkins;

  final List<Checkin> _checkins;

  @override
  Widget build(BuildContext context) {
    final checkins = List<Checkin>.from(_checkins);
    checkins.sort((a, b) => a.timestamp.compareTo(b.timestamp) * -1);

    return Container(
      child: ListView.builder(
        itemCount: checkins.length,
        itemBuilder: (context, index) {
          return _buildCheckinListItem(context, checkins[index]);
        },
        padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  Widget _buildCheckinListItem(BuildContext context, Checkin checkin) {
    final symptoms = checkin.symptoms.toList().map((x) => symptomLabelMap[x]);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(Spacers.lg),
        title: Text(DateFormat.yMMMMd().format(checkin.timestamp),
            overflow: TextOverflow.ellipsis),
        subtitle: Text('Symptoms: ${symptoms.join(', ')}'),
        onTap: () {
          //Navigator.pushNamed(context, RouteName.ViewCheckin, arguments: ViewCheckinScreenRouteData(checkin.id));
        },
      ),
    );
  }
}

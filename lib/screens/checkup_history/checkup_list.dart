import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/extensions/index.dart';
import 'package:vital_circle/themes/typography.dart';
import 'package:vital_circle/utils/symptom_label.dart';

class CheckupListScreen extends StatelessWidget {
  const CheckupListScreen({@required List<Checkup> checkups}) : _checkups = checkups;

  final List<Checkup> _checkups;

  @override
  Widget build(BuildContext context) {
    final checkups = List<Checkup>.from(_checkups);
    checkups.sort((a, b) => a.timestamp.compareTo(b.timestamp) * -1);

    return Container(
      child: ListView.builder(
        itemCount: checkups.length,
        itemBuilder: (context, index) {
          return _buildCheckupListItem(context, checkups[index]);
        },
        padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  Widget _buildCheckupListItem(BuildContext context, Checkup checkup) {
    final symptoms = checkup.symptoms.map((x) => symptomLabelMap[x]);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(Spacers.lg),
        title: Text(DateFormat.yMMMMd().format(checkup.timestamp), overflow: TextOverflow.ellipsis),
        subtitle: Text('Symptoms: ${symptoms.join(', ')}'),
        onTap: () {
          //Navigator.pushNamed(context, RouteName.ViewCheckup, arguments: ViewCheckupScreenRouteData(checkup.id));
        },
      ),
    );
  }
}

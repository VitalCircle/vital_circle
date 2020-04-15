import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/themes/theme.dart';
import 'package:vital_circle/extensions/index.dart';
import 'package:vital_circle/utils/symptom_label.dart';

const double PLAY_BUTTON_SIZE = 48;
const double PAUSE_BUTTON_BORDER_SIZE = 3;
// Not really sure why we don't need to double the border here.
const double PAUSE_BUTTON_SIZE = PLAY_BUTTON_SIZE - (PAUSE_BUTTON_BORDER_SIZE / 2);

class CheckupListScreen extends StatelessWidget {
  const CheckupListScreen({@required List<Checkup> checkups}) : _checkups = checkups;

  final List<Checkup> _checkups;

  @override
  Widget build(BuildContext context) {
    final checkups = List<Checkup>.from(_checkups);
    checkups.where((x) => x.timestamp != null).toList().sort((a, b) => a.timestamp.compareTo(b.timestamp));
    final now = DateTime.now();
    final missingTodaysCheckup = checkups.isEmpty || checkups.first.timestamp.compareDate(now) != 0;
    final indexOffset = missingTodaysCheckup ? 1 : 0;

    return Container(
      child: ListView.builder(
        itemCount: checkups.length + indexOffset,
        itemBuilder: (context, index) {
          if (missingTodaysCheckup && index == 0) {
            return _buildMissingCheckupListItem(context);
          }
          return _buildCheckupListItem(context, checkups[index - indexOffset]);
        },
        padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
      ),
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  Widget _buildMissingCheckupListItem(BuildContext context) {
    return Card(
      child: InkWell(
        child: SizedBox(
          child: Center(child: Text('Perform your daily check-in.', style: Theme.of(context).textTheme.display1)),
          height: 100,
        ),
        onTap: () {
          Navigator.pushNamed(context, RouteName.Checkup);
        },
      ),
      color: AppColors.buttonBackground,
    );
  }

  Widget _buildCheckupListItem(BuildContext context, Checkup checkup) {
    var symptoms = checkup.symptoms.map((x) => symptomLabelMap[x]);
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
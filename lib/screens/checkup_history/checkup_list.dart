import 'package:flutter/material.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/themes/theme.dart';

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
    checkups.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: Spacers.md),
        itemCount: checkups.length,
        itemBuilder: (context, index) {
          return _buildCheckupListItem(context, checkups[index]);
        });
  }

  Widget _buildCheckupListItem(BuildContext context, Checkup checkup) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(Spacers.lg),
        title: Text(checkup.timestamp.toIso8601String(), overflow: TextOverflow.ellipsis),
        subtitle: Text('Test'),
        onTap: () {
          //Navigator.pushNamed(context, RouteName.ViewCheckup, arguments: ViewCheckupScreenRouteData(checkup.id));
        },
      ),
    );
  }
}

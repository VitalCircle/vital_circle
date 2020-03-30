import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teamtemp/shared/shared.dart';
import 'package:teamtemp/themes/theme.dart';

class CheckinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: appBarLeadingAction(context),
        title: const Text('VitalCircle'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/doctor-patient.png',
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Text(
                  'How Are\nYou Feeling?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display3,
                ),
                const SizedBox(height: Spacers.sm),
                Text(
                  'Today, Mar 28, 3:14 PM',
                  style: Theme.of(context).textTheme.display1,
                ),
                SizedBox(height: Spacers.lg),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildCheckinResponse('Great!', FontAwesomeIcons.smile),
                    _buildCheckinResponse('Not Well', FontAwesomeIcons.frown),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      endDrawer: DrawerWidget(),

      // Bottom Nav
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: fabAdd(context),
      bottomNavigationBar: bottomNav(context),
    );
  }

  Widget _buildCheckinResponse(String s, IconData i, [bool isSelected = false]) {
    return InkWell(
      onTap: () {
        // todo: implement for each button
      },
      child: Container(
          decoration: BoxDecoration(color: AppColors.buttonColorInactive, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(vertical: Spacers.md, horizontal: Spacers.md),
          child: Column(
            children: <Widget>[
              Text(s),
              const SizedBox(height: Spacers.sm),
              Icon(i, size: 48),
            ],
          )),
    );
  }
}

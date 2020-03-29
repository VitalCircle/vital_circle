import 'package:flutter/material.dart';
import 'package:teamtemp/routes.dart';
import 'package:teamtemp/shared/shared.dart';
import 'package:teamtemp/themes/theme.dart';

import 'dashboard.vm.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<DashboardViewModel>(
      model: DashboardViewModel.of(context),
      onModelReady: (model) {
        model.onInit();
      },
      builder: (context, model, child) {
        return _buildScreen(context);
      },
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: appBarLeadingAction(context),
        automaticallyImplyLeading: false,
        title: const Text('VitalCircle'),
      ),
      body: Column(
        children: <Widget>[
          _buildFeelingsCard(context),
          _buildTemperatureCard(context),
          _buildThreatLevelCard(context),
        ],
      ),
      endDrawer: DrawerWidget(),

      // Bottom Nav
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: fab(context),
      bottomNavigationBar: bottomNav(context),
    );
  }

  Widget _buildFeelingsCard(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteName.Checkin);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage('assets/how-are-you-feeling.png')),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.accentBlue),
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.topLeft,
            child: _display3Text(context, 'How\nAre You\nFeeling?'),
          ),
        ),
      ),
    );
  }

  Widget _buildTemperatureCard(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          // todo: Record Temp Screen
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.accentGreen),
          child: Center(
            child: _display3Text(context, 'Record Your Temperature'),
          ),
        ),
      ),
    );
  }

  Widget _buildThreatLevelCard(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          // todo: Threat Level Screen
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage('assets/personal-threat-level.png')),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.accentBlue),
            child: Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.topLeft,
              child: _display3Text(context, 'Personal\nExposure\nThreat\nLevel'),
            )),
      ),
    );
  }

  Widget _display3Text(BuildContext context, String v) {
    return Text(
      v,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.display3,
    );
  }
}

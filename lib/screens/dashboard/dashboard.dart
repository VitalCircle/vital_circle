import 'package:flutter/material.dart';
import 'package:vital_circle/screens/checkup_history/checkup_history.dart';
import 'package:vital_circle/shared/shared.dart';

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
        return Scaffold(
          appBar: SharedAppBar(
            title: const Text('Vital Circle'),
          ),
          body: Builder(builder: (BuildContext context) {
            return CheckupHistoryScreen();
          }),
          drawer: DrawerWidget(),
        );
      },
    );
  }
}

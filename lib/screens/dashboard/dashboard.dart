import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/shared/shared.dart';

import 'drawer/drawer.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VitalCircle'),
      ),
      body: Center(
        child: Text('title'),
      ),
      // drawer: DrawerWidget(),
    );
  }
}

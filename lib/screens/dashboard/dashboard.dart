import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/shared/shared.dart';

import 'drawer/drawer.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _test = Provider.of<ModelTest>(context);

    if (_test != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome!'),
        ),
        body: Center(
          child: Text('${_test.title}'),
        ),
        drawer: DrawerWidget(),
      );
    }
    return Loading();
  }
}

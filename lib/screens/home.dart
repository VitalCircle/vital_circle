import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _test = Provider.of<ModelTest>(context);

    if (_test != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Center(
          child: Text('${_test.title}'),
        ),
      );
    }
    return Loading();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/screens/screens.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/themes/material_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _streamTest =
        Firestore.instance.collection('test').document('document').snapshots().map((v) => ModelTest.fromJson(v.data));

    return MultiProvider(
      providers: [StreamProvider<ModelTest>.value(value: _streamTest)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: MaterialThemeModule.build(),
        home: HomeScreen(),
      ),
    );
  }
}

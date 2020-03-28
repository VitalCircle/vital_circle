import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/screens/screens.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/themes/material_theme.dart';

Future main() async {
  // https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();

  // Enable this to verify that Crashlytics is being called
  Crashlytics.instance.enableInDevMode = true;

  // catch framework errors
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // catch application errors
  runZoned<Future<void>>(() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(Main());
  }, onError: Crashlytics.instance.recordError);
}

class Main extends StatelessWidget {
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

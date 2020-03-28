import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teamtemp/screens/screens.dart';
import 'package:teamtemp/services/services.dart';
import 'package:teamtemp/themes/material_theme.dart';

import 'provider_setup.dart';
import 'routes.dart';

Future main() async {
  // https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();

  // Enable this to verify that Crashlytics is being called
  Crashlytics.instance.enableInDevMode = true;

  // https://stackoverflow.com/questions/49707028/check-if-running-app-is-in-debug-mode
  final bool isInDebugMode = kReleaseMode;

  // log is a singleton so we can configure it here
  final log = LogService();
  if (isInDebugMode) {
    log.level = LogLevel.All;
  } else {
    log.level = LogLevel.Error;
  }

  // catch framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    log.error(details.exception, details.stack,
        context: details.context, informationCollector: details.informationCollector);
  };

  // catch application errors
  runZoned<Future<void>>(() async {
    runApp(Main());
  }, onError: (dynamic error, StackTrace stack) {
    log.error(error, stack);
  });
}

class Main extends StatelessWidget {
  final _analytics = FirebaseAnalytics();
  final _logRouteObserver = LogRouteObserver();
  var _streamTest =
      Firestore.instance.collection('test').document('document').snapshots().map((v) => ModelTest.fromJson(v.data));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...ProviderModule.providers, StreamProvider<ModelTest>.value(value: _streamTest)],
      child: MaterialApp(
        title: 'Team Temp',
        theme: MaterialThemeModule.build(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: <NavigatorObserver>[FirebaseAnalyticsObserver(analytics: _analytics), _logRouteObserver],
        initialRoute: RouteName.Boot,
        routes: RouteModule.routes,
      ),
    );
  }
}

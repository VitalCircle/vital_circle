import 'package:flutter/material.dart';

import 'screens/screens.dart';

class RouteName {
  static const String Home = '/';
}

class RouteModule {
  static final routes = <String, WidgetBuilder>{RouteName.Home: (context) => HomeScreen()};
}

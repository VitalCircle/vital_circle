import 'package:flutter/material.dart';

import 'screens/screens.dart';

class RouteName {
  static const String Boot = '/';
  static const String Welcome = '/welcome';
  static const String Dashboard = '/dashboard';
}

class RouteModule {
  static final routes = <String, WidgetBuilder>{
    RouteName.Boot: (context) => BootScreen(),
    RouteName.Welcome: (context) => WelcomeScreen(),
    RouteName.Dashboard: (context) => DashboardScreen(),
  };
}

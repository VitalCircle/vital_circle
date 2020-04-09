import 'package:flutter/material.dart';

import 'screens/screens.dart';

class RouteName {
  static const String Boot = '/';
  static const String Welcome = '/welcome';
  static const String Onboarding = '/onboarding';
  static const String Dashboard = '/dashboard';
  static const String Checkup = '/checkup';
}

class RouteModule {
  static final routes = <String, WidgetBuilder>{
    RouteName.Boot: (context) => BootScreen(),
    RouteName.Welcome: (context) => WelcomeScreen(),
    RouteName.Onboarding: (context) => OnboardingScreen(),
    RouteName.Dashboard: (context) => DashboardScreen(),
    RouteName.Checkup: (context) => CheckupScreen(),
  };
}

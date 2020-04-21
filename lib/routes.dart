import 'package:flutter/material.dart';

import 'screens/screens.dart';

class RouteName {
  static const String Boot = '/';
  static const String Welcome = '/welcome';
  static const String Onboarding = '/onboarding';
  static const String Dashboard = '/dashboard';
  static const String Checkin = '/checkin';
  static const String CheckinSubmitted = '/checkin-submitted';
  static const String CheckinHistory = '/checkin-history';
}

class RouteModule {
  static final routes = <String, WidgetBuilder>{
    RouteName.Boot: (context) => BootScreen(),
    RouteName.Welcome: (context) => WelcomeScreen(),
    RouteName.Onboarding: (context) => OnboardingScreen(),
    RouteName.Dashboard: (context) => DashboardScreen(),
    RouteName.Checkin: (context) => CheckinScreen(),
    RouteName.CheckinSubmitted: (context) => CheckinSubmittedScreen(),
    RouteName.CheckinHistory: (context) => CheckinHistoryScreen(),
  };
}

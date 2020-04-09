import 'package:flutter/widgets.dart';
import 'package:vital_circle/constants/log_zone.dart';

import 'log.service.dart';

class LogRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  factory LogRouteObserver() => _instance;
  LogRouteObserver._internal();
  static final _instance = LogRouteObserver._internal();

  final logService = LogService.zone(LogZone.ROUTE);

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      logService.trace('didPush ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      logService.trace(
          'didReplace ${oldRoute.settings.name} with ${newRoute.settings.name}');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      logService.trace(
          'didPop ${route.settings.name} and replaced with ${previousRoute.settings.name}');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    if (route is PageRoute) {
      if (previousRoute == null) {
        logService.trace('didRemove ${route.settings.name}');
      } else {
        logService.trace(
            'didRemove ${route.settings.name} and replaced with ${route.settings.name}');
      }
    }
  }
}

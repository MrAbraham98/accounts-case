import 'package:accounts/utils/logger/app_logger.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.logInfo('New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    AppLogger.logInfo('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    AppLogger.logInfo('Tab route re-visited: ${route.name}');
  }
}

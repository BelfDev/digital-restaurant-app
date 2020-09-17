import 'package:flutter/material.dart';

typedef NavigationCallback = Function(
    Route<dynamic> route, Route<dynamic> previousRoute);

/// A [NavigatorObserver] that redirects push and pop events to the onNavigation callback.
class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver({
    this.onPop,
    @required this.onPush,
  });

  final NavigationCallback onPop;
  final NavigationCallback onPush;

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPop != null) {
      onPop(route, previousRoute);
    }
  }

  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPush != null) {
      onPush(route, previousRoute);
    }
  }
}

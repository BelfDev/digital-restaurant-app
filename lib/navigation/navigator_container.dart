import 'package:dr_app/navigation/router.dart';
import 'package:dr_app/navigation/screen_navigator_observer.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:flutter/material.dart';

/// A top-level composition of [Navigator] that enables
/// dedicated nested routing for each [BottomNavigationBarItem]
class NavigatorContainer extends StatefulWidget {
  const NavigatorContainer(
      {Key key, this.tabData, this.onNavigation, this.router})
      : super(key: key);

  final TabData tabData;
  final VoidCallback onNavigation;
  final AppRouter router;

  @override
  _NavigatorContainerState createState() => _NavigatorContainerState();
}

class _NavigatorContainerState extends State<NavigatorContainer> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (settings) =>
          widget.router.onGenerateRoute(settings, widget.tabData),
    );
  }
}

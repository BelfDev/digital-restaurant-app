import 'package:dr_app/components/bottom_app_bar.dart';
import 'package:dr_app/navigation/navigatior_container.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:dr_app/navigation/tabs.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This class represents the application UI shell. It initiates the [BottomNavigationBar]
/// with a set of [BottomNavigationBarItem] and manages the navigation between tabs.
class RootContainer extends StatefulWidget {
  @override
  _RootContainerState createState() => _RootContainerState();
}

class _RootContainerState extends State<RootContainer>
    with TickerProviderStateMixin<RootContainer> {
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  int _currentIndex = 0;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    _faders = tabs.map<AnimationController>((TabData destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 200));
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(tabs.length, (int index) => GlobalKey()).toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        backgroundColor: LUColors.smoothWhite,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Stack(
            fit: StackFit.expand,
            children: tabs.map((TabData tabData) {
              final Widget view = FadeTransition(
                opacity: _faders[tabData.index]
                    .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                child: KeyedSubtree(
                  key: _destinationKeys[tabData.index],
                  child: NavigatorContainer(
                    tabData: tabData,
                    onNavigation: () {
                      _hide.forward();
                    },
                  ),
                ),
              );
              if (tabData.index == _currentIndex) {
                _faders[tabData.index].forward();
                return view;
              } else {
                _faders[tabData.index].reverse();
                if (_faders[tabData.index].isAnimating) {
                  return IgnorePointer(child: view);
                }
                return Offstage(child: view);
              }
            }).toList(),
          ),
        ),
        bottomNavigationBar: LUBottomAppBar(
          height: 64,
          iconSize: 28,
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF4F5D75),
          unselectedColor: const Color(0xFFCCCCCC),
          tabs: tabs,
          onTabSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              // Present cart screen
            });
          },
          tooltip: 'Tab',
          child: Icon(Icons.receipt),
          backgroundColor: Color(0xFFEF8354),
          elevation: 4.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

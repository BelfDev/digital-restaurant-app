import 'package:dr_app/components/bottom_app_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/navigation/navigator_container.dart';
import 'package:dr_app/navigation/router.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:dr_app/navigation/tabs.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// This class represents the application UI shell.
/// It initiates the [BottomNavigationBar] with a
/// set of [BottomNavigationBarItem] and manages
/// the navigation between tabs.
class RootContainer extends StatefulWidget {
  final AppRouter router;

  const RootContainer({
    Key key,
    @required this.router,
  })  : assert(router != null),
        super(key: key);

  @override
  _RootContainerState createState() => _RootContainerState();
}

class _RootContainerState extends State<RootContainer>
    with TickerProviderStateMixin<RootContainer> {
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  bool hideFloatingActionButton;
  int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    hideFloatingActionButton = false;
    _faders = tabs.map<AnimationController>((TabData destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 120));
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
    return Scaffold(
      backgroundColor: LUColors.smoothWhite,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: tabs.map((TabData tabData) {
          final Widget view = FadeTransition(
            opacity: _faders[tabData.index]
                .drive(CurveTween(curve: Curves.fastOutSlowIn)),
            child: KeyedSubtree(
              key: _destinationKeys[tabData.index],
              child: NavigatorContainer(
                router: widget.router,
                tabData: tabData,
                onPush: (route, _) {
                  if (route.settings.name == '/') {
                    // Hide the bottom bar on push
                    _hide.forward();
                  } else {
                    // Reveal the bottom bar for root routes
                    _hide.reverse();
                    setState(() {
                      hideFloatingActionButton = true;
                    });
                  }
                },
                onPop: (_, previousRoute) {
                  if (previousRoute.settings.name == '/') {
                    // Reveal the bottom bar for root routes
                    _hide.forward();
                    setState(() {
                      hideFloatingActionButton = false;
                    });
                  }
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
      bottomNavigationBar: SizeTransition(
        sizeFactor: _hide,
        axisAlignment: -1.0,
        child: LUBottomAppBar(
          height: 64,
          iconSize: 28,
          tabs: tabs,
          unselectedColor: Colors.grey.shade400,
          onTabSelected: (int index) {
            setState(() {
              _currentIndex = index;
              if (index == 2) {
                widget.router.navigateToAuthentication(context);
              }
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedOpacity(
        opacity: hideFloatingActionButton ? 0.0 : 1.0,
        duration: Duration(milliseconds: 120),
        child: FloatingActionButton(
          onPressed: () {
            widget.router.navigateToCart(context);
          },
          tooltip: 'Basket',
          child: Icon(
            Entypo.shopping_basket,
            color: LUTheme.of(context).primaryIconTheme.color,
          ),
        ),
      ),
    );
  }
}

import 'package:dr_app/blocs/bloc.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:dr_app/screens/explore_screen.dart';
import 'package:dr_app/screens/home_screen.dart';
import 'package:dr_app/screens/more_screen.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Map<String, Bloc> _blocs;
  Map<String, _ScreenSettings> _routes;

  AppRouter() {
    // Initialize repos
    final cuisineRepository = CuisineRepository();

    // Register blocs
    this._blocs = {
      HomeBloc.id: HomeBloc(cuisineRepository: cuisineRepository),
    };

    // Register routes
    this._routes = {
      OnboardingScreen.id: _ScreenSettings(widget: OnboardingScreen()),
      ExploreScreen.id: _ScreenSettings(widget: ExploreScreen()),
      ProfileScreen.id: _ScreenSettings(widget: ProfileScreen()),
      MoreScreen.id: _ScreenSettings(widget: MoreScreen()),
      HomeScreen.id: _ScreenSettings(widget: HomeScreen(), providers: [
        BlocProvider<HomeBloc>(
          create: (_) => _blocs[HomeBloc.id],
        )
      ]),
    };
  }

  static void navigateToRoot(BuildContext context) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RootContainer()),
          (_) => false);

  Route onGenerateRoute(RouteSettings settings, [TabData tabData]) {
    final rootId = tabData?.rootId ?? HomeScreen.id;
    final destinationId = settings.name == '/' ? rootId : settings.name;
    final screen = _routes[destinationId];

    return MaterialPageRoute(
        settings: settings,
        builder: (_) => screen.hasProviders
            ? MultiBlocProvider(
                providers: screen.providers,
                child: screen.widget,
              )
            : screen.widget);
  }
}

class _ScreenSettings {
  final Widget widget;
  final List<BlocProvider> providers;
  final bool hasProviders;

  _ScreenSettings({@required this.widget, this.providers})
      : this.hasProviders = providers?.isNotEmpty ?? false,
        assert(widget != null);

  @override
  String toString() => widget.toString();
}

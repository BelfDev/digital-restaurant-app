import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/cart/cart_bloc.dart';
import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/data/repositories/cart_repository.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:dr_app/screens/explore_screen.dart';
import 'package:dr_app/screens/home_screen.dart';
import 'package:dr_app/screens/login_screen.dart';
import 'package:dr_app/screens/more_screen.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:dr_app/screens/outlet_screen.dart';
import 'package:dr_app/screens/product_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The AppRouter registers routers based on their identifiers
/// and screen widgets. This class also injects the necessary dependencies.
class AppRouter {
  Map<String, Bloc> _blocs;
  Map<String, _ScreenSettings> _routes;

  AppRouter() {
    // Initialize repos
    final cuisineRepository = CuisineRepository();
    final outletRepository = OutletRepository();
    final cartRepository = CartRepository();

    // Register blocs
    this._blocs = {
      HomeBloc.id: HomeBloc(
        cuisineRepository: cuisineRepository,
        outletRepository: outletRepository,
      ),
      CartBloc.id: CartBloc(cartRepository: cartRepository),
      OutletBloc.id: OutletBloc(outletRepository: outletRepository),
    };

    // Register routes
    this._routes = {
      OnboardingScreen.id: _ScreenSettings(builder: (_) => OnboardingScreen()),
      ExploreScreen.id: _ScreenSettings(builder: (_) => ExploreScreen()),
      ProfileScreen.id: _ScreenSettings(builder: (_) => ProfileScreen()),
      MoreScreen.id: _ScreenSettings(builder: (_) => MoreScreen()),
      HomeScreen.id: _ScreenSettings(
        builder: (_) => HomeScreen(),
        providers: [
          BlocProvider<HomeBloc>(
            create: (_) => _blocs[HomeBloc.id],
          ),
        ],
      ),
      ProductScreen.id: _ScreenSettings(builder: (_) => ProductScreen()),
      ScannerScreen.id: _ScreenSettings(builder: (_) => ScannerScreen()),
      OutletScreen.id: _ScreenSettings(
        builder: (arguments) => OutletScreen(arguments),
        providers: [
          BlocProvider<OutletBloc>(
            create: (_) => _blocs[OutletBloc.id],
          ),
        ],
      ),
      LoginScreen.id: _ScreenSettings(builder: (_) => LoginScreen())
    };
  }

  Route onGenerateRoute(RouteSettings settings, [TabData tabData]) {
    final rootId = tabData?.rootId ?? HomeScreen.id;
    final destinationId = settings.name == '/' ? rootId : settings.name;
    final screen = _routes[destinationId];
    final arguments = settings.arguments;

    return MaterialPageRoute(
        settings: settings,
        builder: (context) => screen.hasProviders
            ? MultiBlocProvider(
                providers: screen.providers,
                child: screen.builder(arguments),
              )
            : screen.builder(arguments));
  }

  static void navigateToRoot(BuildContext context) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RootContainer()),
          (_) => false);
}

typedef ArgumentBuilder = Widget Function(Object arguments);

class _ScreenSettings {
  final ArgumentBuilder builder;
  final List<BlocProvider> providers;
  final bool hasProviders;

  _ScreenSettings({
    @required this.builder,
    this.providers,
  })  : this.hasProviders = providers?.isNotEmpty ?? false,
        assert(builder != null);

  @override
  String toString() => builder.toString();
}

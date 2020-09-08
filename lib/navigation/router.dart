import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/cart/cart_bloc.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/data/repositories/cart_repository.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/data/repositories/order_repository.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:dr_app/data/repositories/payment_repository.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:dr_app/screens/cart_screen.dart';
import 'package:dr_app/screens/explore_screen.dart';
import 'package:dr_app/screens/home_screen.dart';
import 'package:dr_app/screens/login_screen.dart';
import 'package:dr_app/screens/more_screen.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:dr_app/screens/outlet_screen.dart';
import 'package:dr_app/screens/product_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:dr_app/screens/screens.dart';
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
    final orderRepository = OrderRepository();
    final paymentRepository = PaymentRepository();

    // ignore: close_sinks
    final homeBloc = HomeBloc(
      cuisineRepository: cuisineRepository,
      outletRepository: outletRepository,
    );

    // ignore: close_sinks
    final checkOutBloc = CheckOutBloc(
      orderRepository: orderRepository,
      paymentRepository: paymentRepository,
    );
    // ignore: close_sinks
    final cartBloc = CartBloc(
        cartRepository: cartRepository,
        homeBloc: homeBloc,
        checkOutBloc: checkOutBloc);

    // Register blocs
    this._blocs = {
      HomeBloc.id: homeBloc,
      CartBloc.id: cartBloc,
      OutletBloc.id: OutletBloc(outletRepository: outletRepository),
      CheckOutBloc.id: checkOutBloc,
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
      ProductScreen.id: _ScreenSettings(
        builder: (arguments) => ProductScreen(arguments),
        providers: [
          BlocProvider<CartBloc>(
            create: (_) => _blocs[CartBloc.id],
          ),
        ],
      ),
      ScannerScreen.id: _ScreenSettings(builder: (_) => ScannerScreen()),
      OutletScreen.id: _ScreenSettings(
        builder: (arguments) => OutletScreen(arguments),
        providers: [
          BlocProvider<OutletBloc>(
            create: (_) => _blocs[OutletBloc.id],
          ),
        ],
      ),
      CartScreen.id: _ScreenSettings(
        builder: (_) => CartScreen(),
        providers: [
          BlocProvider<CartBloc>(
            create: (_) => _blocs[CartBloc.id],
          ),
        ],
      ),
      PaymentScreen.id:
          _ScreenSettings(builder: (_) => PaymentScreen(), providers: [
        BlocProvider<CheckOutBloc>(
          create: (_) => _blocs[CheckOutBloc.id],
        ),
        BlocProvider<HomeBloc>(
          create: (_) => _blocs[HomeBloc.id],
        )
      ]),
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

  void navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<CartBloc>(
                    create: (_) => _blocs[CartBloc.id],
                  ),
                  BlocProvider<CheckOutBloc>(
                    create: (_) => _blocs[CheckOutBloc.id],
                  )
                ],
                child: CartScreen(),
              )),
    );
  }
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

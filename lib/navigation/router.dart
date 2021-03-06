import 'package:dr_app/blocs/auth/auth_bloc.dart';
import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/cart/cart_bloc.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/data/repositories/account_repository.dart';
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
import 'package:dr_app/screens/outlet_screen.dart';
import 'package:dr_app/screens/product_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:dr_app/screens/screens.dart';
import 'package:dr_app/services/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The AppRouter registers routers based on their identifiers
/// and screen widgets. This class also injects any necessary dependencies.
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
    final accountRepository = AccountRepository();

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
      ExploreScreen.id: _ScreenSettings(builder: (_) => ExploreScreen()),
      ProfileScreen.id: _ScreenSettings(
        builder: (_) => BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            accountRepository: accountRepository,
          ),
          child: ProfileScreen(
            router: this,
          ),
        ),
      ),
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
      LoginScreen.id: _ScreenSettings(
        builder: (_) => LoginScreen(),
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              accountRepository: accountRepository,
            ),
          ),
        ],
      ),
      SignUpScreen.id: _ScreenSettings(
        builder: (_) => SignUpScreen(),
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              accountRepository: accountRepository,
            ),
          ),
        ],
      ),
      CuisineScreen.id: _ScreenSettings(
        builder: (arguments) => CuisineScreen(arguments),
        providers: [
          BlocProvider<OutletBloc>(
            create: (_) => _blocs[OutletBloc.id],
          ),
        ],
      ),
      AboutVersionScreen.id: _ScreenSettings(
        builder: (_) => AboutVersionScreen(),
      ),
      WalletScreen.id: _ScreenSettings(
        builder: (_) => WalletScreen(),
      ),
      AddCreditCardScreen.id: _ScreenSettings(
        builder: (_) => AddCreditCardScreen(),
      ),
    };
  }

  /// Supplies [Route]s to [Navigator]s.
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

  /// Pops all routes and sets the [RootContainer] as the root.
  static void navigateToRoot(BuildContext context, AppRouter router) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => RootContainer(router: router)),
          (_) => false);

  /// Shows the [CartScreen] with a modal presentation.
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
                  ),
                ],
                child: CartScreen(),
              )),
    );
  }

  /// Shows the [LoginScreen] with a modal presentation.
  void navigateToAuthentication(BuildContext context) {
    final sessionManager = SessionManager();
    if (!sessionManager.isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              accountRepository: AccountRepository(),
            ),
            child: LoginScreen(),
          ),
        ),
      );
    }
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

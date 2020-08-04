import 'package:dr_app/screens/add_credit_card_screen.dart';
import 'package:dr_app/screens/category_detail_screen.dart';
import 'package:dr_app/screens/cuisine_screen.dart';
import 'package:dr_app/screens/edit_profile_screen.dart';
import 'package:dr_app/screens/explore_screen.dart';
import 'package:dr_app/screens/favorites_screen.dart';
import 'package:dr_app/screens/home_screen.dart';
import 'package:dr_app/screens/last_visited_screen.dart';
import 'package:dr_app/screens/login_screen.dart';
import 'package:dr_app/screens/more_screen.dart';
import 'package:dr_app/screens/outlet_detail_screen.dart';
import 'package:dr_app/screens/outlet_screen.dart';
import 'package:dr_app/screens/product_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:dr_app/screens/wallet_screen.dart';
import 'package:flutter/widgets.dart';

/// A map of the named routes used for navigation.
final Map<String, WidgetBuilder> routes = {
  HomeScreen.id: (context) => HomeScreen(),
  ExploreScreen.id: (context) => ExploreScreen(),
  ProfileScreen.id: (context) => ProfileScreen(),
  MoreScreen.id: (context) => MoreScreen(),
  ScannerScreen.id: (context) => ScannerScreen(),
  OutletDetailScreen.id: (context) => OutletDetailScreen(),
  CategoryDetailScreen.id: (context) => CategoryDetailScreen(),
  CuisineScreen.id: (context) => CuisineScreen(),
  ProductScreen.id: (context) => ProductScreen(),
  OutletScreen.id: (context) => OutletScreen(),
  WalletScreen.id: (context) => WalletScreen(),
  FavoritesScreen.id: (context) => FavoritesScreen(),
  LastVisitedScreen.id: (context) => LastVisitedScreen(),
  AddCreditCardScreen.id: (context) => AddCreditCardScreen(),
  EditProfileScreen.id: (context) => EditProfileScreen(),
  LoginScreen.id: (context) => LoginScreen(),
};

final Set<String> fullScreenRoutes = {ScannerScreen.id};

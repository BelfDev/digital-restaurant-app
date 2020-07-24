import 'package:dr_app/screens/cart_screen.dart';
import 'package:dr_app/screens/category_detail_screen.dart';
import 'package:dr_app/screens/cuisine_screen.dart';
import 'package:dr_app/screens/explore_screen.dart';
import 'package:dr_app/screens/home_screen.dart';
import 'package:dr_app/screens/more_screen.dart';
import 'package:dr_app/screens/outlet_detail_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.id: (context) => HomeScreen(),
  ExploreScreen.id: (context) => ExploreScreen(),
  CartScreen.id: (context) => CartScreen(),
  ProfileScreen.id: (context) => ProfileScreen(),
  MoreScreen.id: (context) => MoreScreen(),
  ScannerScreen.id: (context) => ScannerScreen(),
  OutletDetailScreen.id: (context) => OutletDetailScreen(),
  CategoryDetailScreen.id: (context) => CategoryDetailScreen(),
  CuisineScreen.id: (context) => CuisineScreen()
};

final Set<String> fullScreenRoutes = {ScannerScreen.id};

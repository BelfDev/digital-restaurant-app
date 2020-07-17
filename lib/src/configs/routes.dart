import 'package:dr_app/src/screens/cart_screen.dart';
import 'package:dr_app/src/screens/category_detail_screen.dart';
import 'package:dr_app/src/screens/explore_screen.dart';
import 'package:dr_app/src/screens/home_screen.dart';
import 'package:dr_app/src/screens/more_screen.dart';
import 'package:dr_app/src/screens/outlet_detail_screen.dart';
import 'package:dr_app/src/screens/profile_screen.dart';
import 'package:dr_app/src/screens/scanner_screen.dart';
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
};

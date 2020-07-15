import 'package:dr_app/src/screens/category_detail_screen.dart';
import 'package:dr_app/src/screens/home_screen.dart';
import 'package:dr_app/src/screens/outlet_detail_screen.dart';
import 'package:dr_app/src/screens/scanner_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.id: (context) => HomeScreen(),
  ScannerScreen.id: (context) => ScannerScreen(),
  OutletDetailScreen.id: (context) => OutletDetailScreen(),
  CategoryDetailScreen.id: (context) => CategoryDetailScreen(),
};

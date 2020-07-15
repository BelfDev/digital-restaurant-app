import 'package:dr_app/src/configs/routes.dart';
import 'package:dr_app/src/configs/theme.dart';
import 'package:dr_app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      initialRoute: HomeScreen.id,
      routes: routes,
    );
  }
}

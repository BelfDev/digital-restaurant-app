import 'package:dr_app/src/configs/theme.dart';
import 'package:dr_app/src/navigation/root_container.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      home: RootContainer(),
    );
  }
}

import 'package:flutter/material.dart';

import 'configs/theme.dart';
import 'navigation/root_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      home: RootContainer(),
    );
  }
}

import 'package:dr_app/configs/routes.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

import 'configs/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      home: OnboardingScreen(),
      routes: routes,
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/theme.dart';
import 'screens/screens.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      home: OnboardingScreen(),
    );
  }
}

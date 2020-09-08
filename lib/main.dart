import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/app_bloc_observer.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:dr_app/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/theme.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  final router = AppRouter();
  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      onGenerateRoute: router.onGenerateRoute,
      home: RootContainer(
        router: router,
      ),
      // home: OnboardingScreen(),
    );
  }
}

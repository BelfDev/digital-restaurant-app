import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/app_bloc_observer.dart';
import 'package:dr_app/navigation/router.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs/theme.dart';
import 'navigation/root_container.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  final router = AppRouter();
  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatelessWidget {
  static const isFirstLaunchKey = 'is-first-launch';
  final AppRouter router;

  const MyApp({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      onGenerateRoute: router.onGenerateRoute,
      home: FutureBuilder<bool>(
          future: isFirstLaunch,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Container(
                color: Colors.white,
              );

            if (snapshot.data) {
              return RootContainer(
                router: router,
              );
            } else {
              return OnboardingScreen(
                router: router,
              );
            }
          }),
    );
  }

  Future<bool> get isFirstLaunch async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(isFirstLaunchKey);
  }
}

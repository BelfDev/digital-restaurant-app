import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/app_bloc_observer.dart';
import 'package:dr_app/navigation/router.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs/theme.dart';
import 'navigation/root_container.dart';

/// The App's entry-point. Runs the [AppContainer] widget defined below.
void main() {
  Bloc.observer = AppBlocObserver();
  final router = AppRouter();
  runApp(AppContainer(
    router: router,
  ));
}

/// A [StatelessWidget] that provides app-wide configurations.
/// Properties include:
/// - Theme
/// - Routes
///
/// This widget checks if it is the user's first launch. If so,
/// the home route is set to the [OnboardingScreen]; otherwise,
/// the home route is set to the [RootContainer].
class AppContainer extends StatelessWidget {
  static const isFirstLaunchKey = 'is-first-launch';
  final AppRouter router;

  const AppContainer({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      onGenerateRoute: router.onGenerateRoute,
      home: FutureBuilder<bool>(
          future: _isFirstLaunch,
          builder: (context, snapshot) {
            // Display a white screen while the first launch key is verified
            if (snapshot.data == null)
              return Container(
                color: Colors.white,
              );
            if (snapshot.data) {
              // Redirects to the root container if this is not the first launch
              return RootContainer(
                router: router,
              );
            } else {
              // Shows the onboarding screen if this is the first launch
              return OnboardingScreen(
                router: router,
              );
            }
          }),
    );
  }

  Future<bool> get _isFirstLaunch async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(isFirstLaunchKey);
  }
}

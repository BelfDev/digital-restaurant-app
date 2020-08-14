import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/app_bloc_observer.dart';
import 'package:dr_app/blocs/bloc.dart';
import 'package:dr_app/configs/routes.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/theme.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  final CuisineRepository cuisineRepo = CuisineRepository();

  // Injects all available repos
  runApp(MyApp(
    cuisineRepo: cuisineRepo,
  ));
}

class MyApp extends StatelessWidget {
  final CuisineRepository cuisineRepo;

  const MyApp({Key key, @required this.cuisineRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LUTheme.of(context),
      home: BlocProvider(
        create: (context) => HomeBloc(cuisineRepo: cuisineRepo),
        child: OnboardingScreen(),
      ),
      routes: routes,
    );
  }
}

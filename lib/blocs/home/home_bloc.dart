import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const id = 'home_bloc';

  final CuisineRepository cuisineRepository;

  HomeBloc({@required this.cuisineRepository})
      : assert(cuisineRepository != null),
        super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is CuisineRequested) {
      yield* _mapCuisineRequestedToState();
    }
  }

  Stream<HomeState> _mapCuisineRequestedToState() async* {
    yield HomeLoadInProgress();
    try {
      final List<Cuisine> cuisines = await cuisineRepository.fetchAllCuisines();
      yield CuisineLoadSuccess(cuisines: cuisines);
    } catch (_) {
      yield HomeLoadFailure();
    }
  }
}

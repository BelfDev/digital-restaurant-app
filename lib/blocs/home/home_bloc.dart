import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/data/models/remote/outlet.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

/// This BLoC class encapsulates all business logic with respect to the [HomeScreen].
/// Events are identified and mapped into States, which are emitted back to the UI.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const id = 'home_bloc';

  final CuisineRepository cuisineRepository;
  final OutletRepository outletRepository;

  HomeBloc({@required this.cuisineRepository, @required this.outletRepository})
      : assert(cuisineRepository != null),
        super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case FeaturedOutletsRequested:
        yield* _mapFeaturedOutletsRequestedToState(event);
        break;
      case CuisinesRequested:
        yield* _mapCuisinesRequestedToState();
        break;
      case NearbyOutletsRequested:
        yield* _mapNearbyOutletsRequestedToState(event);
        break;
    }
  }

  Stream<HomeState> _mapFeaturedOutletsRequestedToState(
      FeaturedOutletsRequested event) async* {
    yield FeaturedOutletLoadInProgress();
    try {
      final List<Outlet> featuredOutlets =
          await outletRepository.fetchAllFeaturedOutlets(event?.city);
      yield FeaturedOutletLoadSuccess(outlets: featuredOutlets);
    } catch (error) {
      yield FeaturedOutletLoadFailure();
    }
  }

  Stream<HomeState> _mapCuisinesRequestedToState() async* {
    yield CuisineLoadInProgress();
    try {
      final List<Cuisine> cuisines = await cuisineRepository.fetchAllCuisines();
      yield CuisineLoadSuccess(cuisines: cuisines);
    } catch (error) {
      yield CuisineLoadFailure();
    }
  }

  Stream<HomeState> _mapNearbyOutletsRequestedToState(
      NearbyOutletsRequested event) async* {
    yield NearbyOutletLoadInProgress();
    try {
      final List<Outlet> nearbyOutlets =
          await outletRepository.fetchAllOutlets(event?.city);
      yield NearbyOutletLoadSuccess(outlets: nearbyOutlets);
    } catch (_) {
      yield NearbyOutletLoadFailure();
    }
  }
}

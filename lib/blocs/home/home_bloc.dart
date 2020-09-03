import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/data/models/remote/outlet.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../content_state_status.dart';

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
        super(HomeState.initial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case CheckInRequested:
        yield* _mapCheckInRequestedToState(event);
        break;
      case CheckOutRequested:
        yield* _mapCheckOutRequestedToState(event);
        break;
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

  Stream<HomeState> _mapCheckInRequestedToState(CheckInRequested event) async* {
    yield state.copyWith(
      mode: HomeMode.checkedIn,
      homeOutlet: Outlet(
        2,
        'Nice',
        2,
        4,
        Cuisine(1, 'Nice', null),
        [],
        Location('Glasgow'),
      ),
    );
  }

  Stream<HomeState> _mapCheckOutRequestedToState(
      CheckOutRequested event) async* {
    yield state.copyWith(mode: HomeMode.checkedOut, homeOutlet: null);
  }

  Stream<HomeState> _mapFeaturedOutletsRequestedToState(
      FeaturedOutletsRequested event) async* {
    yield state.copyWith(
        featuredOutletsStatus: ContentStateStatus.loadInProgress);
    try {
      final List<Outlet> featuredOutlets =
          await outletRepository.fetchAllFeaturedOutlets(event?.city);
      yield state.copyWith(
          featuredOutletsStatus: ContentStateStatus.loadSuccess,
          featuredOutlets: featuredOutlets);
    } catch (error) {
      yield state.copyWith(
          featuredOutletsStatus: ContentStateStatus.loadFailure);
    }
  }

  Stream<HomeState> _mapCuisinesRequestedToState() async* {
    yield state.copyWith(cuisineStatus: ContentStateStatus.loadInProgress);
    try {
      final List<Cuisine> cuisines = await cuisineRepository.fetchAllCuisines();
      yield state.copyWith(
          cuisineStatus: ContentStateStatus.loadSuccess, cuisines: cuisines);
    } catch (error) {
      yield state.copyWith(cuisineStatus: ContentStateStatus.loadFailure);
    }
  }

  Stream<HomeState> _mapNearbyOutletsRequestedToState(
      NearbyOutletsRequested event) async* {
    yield state.copyWith(
        nearbyOutletsStatus: ContentStateStatus.loadInProgress);
    try {
      final List<Outlet> nearbyOutlets =
          await outletRepository.fetchAllOutlets(event?.city);
      yield state.copyWith(
          nearbyOutletsStatus: ContentStateStatus.loadSuccess,
          nearbyOutlets: nearbyOutlets);
    } catch (_) {
      yield state.copyWith(nearbyOutletsStatus: ContentStateStatus.loadFailure);
    }
  }
}

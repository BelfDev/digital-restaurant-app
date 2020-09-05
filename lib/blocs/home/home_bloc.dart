import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/data/models/remote/outlet.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  HomeBloc({
    @required this.cuisineRepository,
    @required this.outletRepository,
  })  : assert(cuisineRepository != null),
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
      case OutletProductsRequested:
        yield* _mapOutletProductsRequestedToState(event);
        break;
      case OutletFeaturedProductsRequested:
        yield* _mapOutletFeaturedProductsRequestedToState(event);
        break;
    }
  }

  Stream<HomeState> _mapCheckInRequestedToState(CheckInRequested event) async* {
    // Loading
    yield state.copyWith(
      mode: HomeMode.checkedIn,
      homeOutletStatus: ContentStateStatus.loadInProgress,
      featuredOutlets: const [],
      cuisines: const [],
      nearbyOutlets: const [],
      featuredOutletsStatus: ContentStateStatus.initial,
      cuisineStatus: ContentStateStatus.initial,
      nearbyOutletsStatus: ContentStateStatus.initial,
    );
    try {
      // Success
      final outlet = await outletRepository.fetchOutlet(event.outletId);
      yield state.copyWith(
          homeOutletStatus: ContentStateStatus.loadSuccess, homeOutlet: outlet);
    } catch (error) {
      // Error
      yield state.copyWith(homeOutletStatus: ContentStateStatus.loadFailure);
    }
  }

  Stream<HomeState> _mapCheckOutRequestedToState(
      CheckOutRequested event) async* {
    yield state.copyWith(
      mode: HomeMode.checkedOut,
      homeOutlet: null,
      homeOutletStatus: ContentStateStatus.initial,
      featuredProducts: const [],
      categories: const {},
    );
  }

  Stream<HomeState> _mapOutletFeaturedProductsRequestedToState(
      OutletFeaturedProductsRequested event) async* {
    // Loading
    yield state.copyWith(
        featuredProductsStatus: ContentStateStatus.loadInProgress);
    try {
      // Success
      final List<Product> featuredProducts =
          await outletRepository.fetchAllOutletFeaturedProducts(event.outletId);
      yield state.copyWith(
          featuredProductsStatus: ContentStateStatus.loadSuccess,
          featuredProducts: featuredProducts);
    } catch (error) {
      // Error
      yield state.copyWith(
          featuredProductsStatus: ContentStateStatus.loadFailure);
    }
  }

  Stream<HomeState> _mapOutletProductsRequestedToState(
      OutletProductsRequested event) async* {
    yield state.copyWith(productsStatus: ContentStateStatus.loadInProgress);
    try {
      final List<Product> products =
          await outletRepository.fetchAllOutletProducts(event.outletId);

      // Generate categories map
      final Map<Category, List<Product>> categoryMap =
          Map<Category, List<Product>>();
      products.forEach((product) {
        final productCategories = product.categories;
        productCategories.forEach((category) {
          if (!categoryMap.containsKey(category)) {
            categoryMap[category] = List<Product>();
          }
          categoryMap[category].add(product);
        });
      });

      // Return categoryMap
      yield state.copyWith(
          productsStatus: ContentStateStatus.loadSuccess,
          categories: categoryMap);
    } catch (error) {
      yield state.copyWith(productsStatus: ContentStateStatus.loadFailure);
    }
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

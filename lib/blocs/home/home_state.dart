part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

// Cuisine States
class CuisineLoadInProgress extends HomeState {}

class CuisineLoadSuccess extends HomeState {
  final List<Cuisine> cuisines;

  const CuisineLoadSuccess({@required this.cuisines})
      : assert(cuisines != null);

  @override
  List<Object> get props => [cuisines];
}

class CuisineLoadFailure extends HomeState {}

// Featured outlet states
class FeaturedOutletLoadInProgress extends HomeState {}

class FeaturedOutletLoadSuccess extends HomeState {
  final List<Outlet> outlets;

  const FeaturedOutletLoadSuccess({@required this.outlets})
      : assert(outlets != null);

  @override
  List<Object> get props => [outlets];
}

class FeaturedOutletLoadFailure extends HomeState {}

// Nearby outlet states
class NearbyOutletLoadInProgress extends HomeState {}

class NearbyOutletLoadSuccess extends HomeState {
  final List<Outlet> outlets;

  const NearbyOutletLoadSuccess({@required this.outlets})
      : assert(outlets != null);

  @override
  List<Object> get props => [outlets];
}

class NearbyOutletLoadFailure extends HomeState {}

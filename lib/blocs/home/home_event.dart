part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CuisinesRequested extends HomeEvent {}

class FeaturedOutletsRequested extends HomeEvent {
  final String city;

  const FeaturedOutletsRequested({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class NearbyOutletsRequested extends HomeEvent {
  final String city;

  const NearbyOutletsRequested({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class CheckInRequested extends HomeEvent {
  final int outletId;

  const CheckInRequested(this.outletId) : assert(outletId != null);

  @override
  List<Object> get props => [outletId];
}

class CheckOutRequested extends HomeEvent {}

class OutletProductsRequested extends HomeEvent {
  final int outletId;

  const OutletProductsRequested(this.outletId) : assert(outletId != null);

  @override
  List<Object> get props => [outletId];
}

class OutletFeaturedProductsRequested extends HomeEvent {
  final int outletId;

  const OutletFeaturedProductsRequested(this.outletId)
      : assert(outletId != null);

  @override
  List<Object> get props => [outletId];
}

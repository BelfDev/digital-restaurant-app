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

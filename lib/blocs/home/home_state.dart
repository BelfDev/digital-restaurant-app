part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadInProgress extends HomeState {}

class CuisineLoadSuccess extends HomeState {
  final List<Cuisine> cuisines;

  const CuisineLoadSuccess({@required this.cuisines})
      : assert(cuisines != null);

  @override
  List<Object> get props => [cuisines];
}

class HomeLoadFailure extends HomeState {}

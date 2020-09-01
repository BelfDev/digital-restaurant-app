part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ContentStateStatus cuisineStatus;
  final ContentStateStatus featuredOutletsStatus;
  final ContentStateStatus nearbyOutletsStatus;

  final List<Cuisine> cuisines;
  final List<Outlet> featuredOutlets;
  final List<Outlet> nearbyOutlets;

  const HomeState({
    this.cuisineStatus = ContentStateStatus.initial,
    this.featuredOutletsStatus = ContentStateStatus.initial,
    this.nearbyOutletsStatus = ContentStateStatus.initial,
    this.cuisines = const [],
    this.featuredOutlets = const [],
    this.nearbyOutlets = const [],
  });

  factory HomeState.initial() => HomeState();

  HomeState copyWith({
    ContentStateStatus cuisineStatus,
    ContentStateStatus featuredOutletsStatus,
    ContentStateStatus nearbyOutletsStatus,
    List<Cuisine> cuisines,
    List<Outlet> featuredOutlets,
    List<Outlet> nearbyOutlets,
  }) =>
      HomeState(
          cuisineStatus: cuisineStatus ?? this.cuisineStatus,
          featuredOutletsStatus:
              featuredOutletsStatus ?? this.featuredOutletsStatus,
          nearbyOutletsStatus: nearbyOutletsStatus ?? this.nearbyOutletsStatus,
          cuisines: cuisines ?? this.cuisines,
          featuredOutlets: featuredOutlets ?? this.featuredOutlets,
          nearbyOutlets: nearbyOutlets ?? this.nearbyOutlets);

  @override
  List<Object> get props => [
        cuisineStatus,
        featuredOutletsStatus,
        nearbyOutletsStatus,
        cuisines,
        featuredOutlets,
        nearbyOutlets
      ];

  @override
  String toString() {
    return [cuisineStatus, featuredOutletsStatus, nearbyOutletsStatus]
        .join('\n')
        .toString();
  }
}

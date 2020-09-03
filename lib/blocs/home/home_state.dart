part of 'home_bloc.dart';

enum HomeMode { checkedIn, checkedOut }

class HomeState extends Equatable {
  final HomeMode mode;
  final Outlet homeOutlet;

  final ContentStateStatus cuisineStatus;
  final ContentStateStatus featuredOutletsStatus;
  final ContentStateStatus nearbyOutletsStatus;

  final List<Cuisine> cuisines;
  final List<Outlet> featuredOutlets;
  final List<Outlet> nearbyOutlets;

  const HomeState({
    this.mode = HomeMode.checkedOut,
    this.homeOutlet,
    this.cuisineStatus = ContentStateStatus.initial,
    this.featuredOutletsStatus = ContentStateStatus.initial,
    this.nearbyOutletsStatus = ContentStateStatus.initial,
    this.cuisines = const [],
    this.featuredOutlets = const [],
    this.nearbyOutlets = const [],
  });

  factory HomeState.initial() => HomeState();

  HomeState copyWith({
    HomeMode mode,
    Outlet homeOutlet,
    ContentStateStatus cuisineStatus,
    ContentStateStatus featuredOutletsStatus,
    ContentStateStatus nearbyOutletsStatus,
    List<Cuisine> cuisines,
    List<Outlet> featuredOutlets,
    List<Outlet> nearbyOutlets,
  }) =>
      HomeState(
          mode: mode ?? this.mode,
          homeOutlet: homeOutlet ?? this.homeOutlet,
          cuisineStatus: cuisineStatus ?? this.cuisineStatus,
          featuredOutletsStatus:
              featuredOutletsStatus ?? this.featuredOutletsStatus,
          nearbyOutletsStatus: nearbyOutletsStatus ?? this.nearbyOutletsStatus,
          cuisines: cuisines ?? this.cuisines,
          featuredOutlets: featuredOutlets ?? this.featuredOutlets,
          nearbyOutlets: nearbyOutlets ?? this.nearbyOutlets);

  @override
  List<Object> get props => [
        mode,
        cuisineStatus,
        featuredOutletsStatus,
        nearbyOutletsStatus,
        cuisines,
        featuredOutlets,
        nearbyOutlets
      ];

  @override
  String toString() {
    return [mode, cuisineStatus, featuredOutletsStatus, nearbyOutletsStatus]
        .join('\n')
        .toString();
  }
}

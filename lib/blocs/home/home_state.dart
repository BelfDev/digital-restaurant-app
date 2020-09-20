part of 'home_bloc.dart';

enum HomeMode { checkedIn, checkedOut }

/// States related to the Home screen
class HomeState extends Equatable {
  final HomeMode mode;
  final Outlet homeOutlet;

  final ContentStateStatus homeOutletStatus;

  final ContentStateStatus cuisineStatus;
  final ContentStateStatus featuredOutletsStatus;
  final ContentStateStatus nearbyOutletsStatus;

  final ContentStateStatus featuredProductsStatus;
  final ContentStateStatus productsStatus;

  final List<Cuisine> cuisines;
  final List<Outlet> featuredOutlets;
  final List<Outlet> nearbyOutlets;

  final Map<Category, List<Product>> categories;
  final List<Product> featuredProducts;

  const HomeState({
    this.mode = HomeMode.checkedOut,
    this.homeOutlet,
    this.homeOutletStatus = ContentStateStatus.initial,
    this.cuisineStatus = ContentStateStatus.initial,
    this.featuredOutletsStatus = ContentStateStatus.initial,
    this.nearbyOutletsStatus = ContentStateStatus.initial,
    this.featuredProductsStatus = ContentStateStatus.initial,
    this.productsStatus = ContentStateStatus.initial,
    this.cuisines = const [],
    this.featuredOutlets = const [],
    this.nearbyOutlets = const [],
    this.featuredProducts = const [],
    this.categories = const {},
  });

  factory HomeState.initial() => HomeState();

  HomeState copyWith({
    HomeMode mode,
    Outlet homeOutlet,
    ContentStateStatus homeOutletStatus,
    ContentStateStatus cuisineStatus,
    ContentStateStatus featuredOutletsStatus,
    ContentStateStatus nearbyOutletsStatus,
    ContentStateStatus featuredProductsStatus,
    ContentStateStatus productsStatus,
    List<Cuisine> cuisines,
    List<Outlet> featuredOutlets,
    List<Outlet> nearbyOutlets,
    Map<Category, List<Product>> categories,
    List<Product> featuredProducts,
  }) =>
      HomeState(
        mode: mode ?? this.mode,
        homeOutlet: homeOutlet ?? this.homeOutlet,
        homeOutletStatus: homeOutletStatus ?? this.homeOutletStatus,
        cuisineStatus: cuisineStatus ?? this.cuisineStatus,
        featuredOutletsStatus:
            featuredOutletsStatus ?? this.featuredOutletsStatus,
        nearbyOutletsStatus: nearbyOutletsStatus ?? this.nearbyOutletsStatus,
        featuredProductsStatus:
            featuredProductsStatus ?? this.featuredProductsStatus,
        productsStatus: productsStatus ?? this.productsStatus,
        cuisines: cuisines ?? this.cuisines,
        featuredOutlets: featuredOutlets ?? this.featuredOutlets,
        nearbyOutlets: nearbyOutlets ?? this.nearbyOutlets,
        featuredProducts: featuredProducts ?? this.featuredProducts,
        categories: categories ?? this.categories,
      );

  @override
  List<Object> get props => [
        mode,
        homeOutlet,
        homeOutletStatus,
        cuisineStatus,
        featuredOutletsStatus,
        nearbyOutletsStatus,
        featuredProductsStatus,
        productsStatus,
        cuisines,
        featuredOutlets,
        nearbyOutlets,
        featuredProducts,
        categories,
      ];

  @override
  String toString() {
    return [
      mode,
      homeOutletStatus,
      cuisineStatus,
      featuredOutletsStatus,
      nearbyOutletsStatus,
      featuredProductsStatus,
      productsStatus,
    ].join('\n').toString();
  }
}

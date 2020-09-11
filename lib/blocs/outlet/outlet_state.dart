part of 'outlet_bloc.dart';

class OutletState extends Equatable {
  final ContentStateStatus status;
  final Map<Category, List<Product>> categoryMap;
  final List<Outlet> outlets;

  const OutletState({
    @required this.status,
    this.categoryMap = const {},
    this.outlets = const [],
  })  : assert(status != null),
        assert(categoryMap != null);

  Set<Category> get categories => categoryMap?.keys?.toSet() ?? Set<Category>();

  factory OutletState.initial() => OutletState(
        status: ContentStateStatus.initial,
      );

  factory OutletState.loading() => OutletState(
        status: ContentStateStatus.loadInProgress,
      );

  factory OutletState.success(
          Map<Category, List<Product>> categoryMap, List<Outlet> outlets) =>
      OutletState(
          status: ContentStateStatus.loadSuccess,
          categoryMap: categoryMap,
          outlets: outlets);

  factory OutletState.error() => OutletState(
        status: ContentStateStatus.loadFailure,
      );

  @override
  List<Object> get props => [status, categoryMap];

  @override
  String toString() {
    return status.toString();
  }
}

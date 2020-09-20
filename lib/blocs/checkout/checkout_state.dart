part of 'checkout_bloc.dart';

/// States related to the Checkout
class CheckOutState extends Equatable {
  final ContentStateStatus status;
  final Order order;

  const CheckOutState({
    @required this.status,
    @required this.order,
  }) : assert(status != null);

  List<Product> get items =>
      order?.carts?.map((cart) => cart.items)?.expand((list) => list)?.toList();

  factory CheckOutState.initial(Order order) => CheckOutState(
        status: ContentStateStatus.initial,
        order: order,
      );

  factory CheckOutState.loading(Order order) => CheckOutState(
        status: ContentStateStatus.loadInProgress,
        order: order,
      );

  factory CheckOutState.success(Order order) => CheckOutState(
        status: ContentStateStatus.loadSuccess,
        order: order,
      );

  factory CheckOutState.error(Order order) => CheckOutState(
        status: ContentStateStatus.loadFailure,
        order: order,
      );

  @override
  List<Object> get props => [status, order];

  @override
  String toString() {
    return status.toString();
  }
}

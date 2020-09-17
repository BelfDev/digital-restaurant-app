part of 'cart_bloc.dart';

class CartState extends Equatable {
  final ContentStateStatus status;
  final Cart cart;
  final int outletId;

  const CartState({this.status, this.cart, this.outletId});

  factory CartState.initial() => CartState(
        status: ContentStateStatus.initial,
      );

  CartState copyWith({
    ContentStateStatus status,
    Cart cart,
    int outletId,
  }) =>
      CartState(
        status: status ?? this.status,
        cart: cart ?? this.cart,
        outletId: outletId ?? this.outletId,
      );

  @override
  List<Object> get props => [status, cart, outletId];

  @override
  String toString() {
    return [status, cart, outletId].join('\n').toString();
  }
}

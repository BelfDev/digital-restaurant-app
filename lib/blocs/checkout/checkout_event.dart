part of 'checkout_bloc.dart';

@immutable
abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();

  @override
  List<Object> get props => [];
}

class AddCartToOrderRequested extends CheckOutEvent {
  final int cartId;

  const AddCartToOrderRequested(this.cartId);

  @override
  List<Object> get props => [cartId];
}

class ClearOrderRequested extends CheckOutEvent {}

class MakePaymentRequested extends CheckOutEvent {
  final int orderId;
  final int paymentMethodId;

  const MakePaymentRequested(this.orderId, this.paymentMethodId);

  @override
  List<Object> get props => [orderId, paymentMethodId];
}

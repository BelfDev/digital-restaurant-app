part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartRequested extends CartEvent {}

class NewCartRequested extends CartEvent {
  final int outletId;

  const NewCartRequested(this.outletId);

  @override
  List<Object> get props => [outletId];
}

class ClearCartRequested extends CartEvent {}

class AddToCartRequested extends CartEvent {
  final int productId;
  final int quantity;

  const AddToCartRequested(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class RemoveCartItemRequested extends CartEvent {
  final int productId;

  const RemoveCartItemRequested(this.productId);

  @override
  List<Object> get props => [productId];
}

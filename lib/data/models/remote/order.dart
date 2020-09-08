import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart.dart';

part 'order.g.dart';

enum OrderStatus {
  @JsonValue('OPEN')
  OPEN,
  @JsonValue('PAID')
  PAID
}

/// A representation of the Order entity.
@JsonSerializable()
class Order extends Equatable {
  final int id;
  final double subtotal;
  final OrderStatus status;
  final List<Cart> carts;

  const Order(this.id, this.subtotal, this.status, this.carts);

  static Order fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  List<Object> get props => [id, subtotal, status, carts];
}

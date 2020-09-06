import 'package:dr_app/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

enum CartStatus {
  @JsonValue('NOT_ORDERED')
  NOT_ORDERED,
  @JsonValue('ORDERED')
  ORDERED
}

@JsonSerializable()
class Cart extends Equatable {
  final int id;
  final double subtotal;
  final CartStatus status;
  final List<Product> items;

  const Cart(this.id, this.subtotal, this.status, this.items);

  static Cart fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  @override
  List<Object> get props => [id, subtotal, status];
}

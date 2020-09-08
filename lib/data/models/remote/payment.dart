import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// A representation of the Payment entity.
@JsonSerializable()
class Payment extends Equatable {
  final int id;
  final double total;
  final int orderId;
  final int paymentMethodId;

  const Payment(this.id, this.total, this.orderId, this.paymentMethodId);

  static Payment fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  List<Object> get props => [id, total, orderId, paymentMethodId];
}

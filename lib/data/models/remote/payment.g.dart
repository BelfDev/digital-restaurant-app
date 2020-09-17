// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    json['id'] as int,
    (json['total'] as num)?.toDouble(),
    json['orderId'] as int,
    json['paymentMethodId'] as int,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'orderId': instance.orderId,
      'paymentMethodId': instance.paymentMethodId,
    };

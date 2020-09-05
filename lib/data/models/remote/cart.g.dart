// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    json['id'] as int,
    (json['subtotal'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'subtotal': instance.subtotal,
    };

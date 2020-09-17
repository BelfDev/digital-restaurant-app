// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCode _$QRCodeFromJson(Map<String, dynamic> json) {
  return QRCode(
    json['id'] as int,
    json['name'] as String,
    json['brand'] as String,
  );
}

Map<String, dynamic> _$QRCodeToJson(QRCode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
    };

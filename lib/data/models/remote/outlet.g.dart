// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outlet _$OutletFromJson(Map<String, dynamic> json) {
  return Outlet(
    json['id'] as int,
    json['title'] as String,
    (json['rating'] as num)?.toDouble(),
    json['priceLevel'] as int,
    json['cuisine'] == null
        ? null
        : Cuisine.fromJson(json['cuisine'] as Map<String, dynamic>),
    (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'rating': instance.rating,
      'priceLevel': instance.priceLevel,
      'cuisine': instance.cuisine,
      'location': instance.location,
      'images': instance.images,
    };

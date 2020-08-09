// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuisine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cuisine _$CuisineFromJson(Map<String, dynamic> json) {
  return Cuisine(
    json['id'] as int,
    json['title'] as String,
    json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CuisineToJson(Cuisine instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };

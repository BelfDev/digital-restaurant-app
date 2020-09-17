import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

/// A representation of the Image entity.
@JsonSerializable()
class Image {
  final String source;

  Image(this.source);

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

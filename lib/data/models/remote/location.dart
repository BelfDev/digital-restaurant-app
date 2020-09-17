import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// A representation of the Location entity.
@JsonSerializable()
class Location {
  final String city;

  Location(this.city);

  static Location fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

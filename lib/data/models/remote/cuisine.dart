import 'package:dr_app/data/models/remote/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cuisine.g.dart';

/// A representation of the Cuisine entity.
@JsonSerializable()
class Cuisine {
  final int id;
  final String title;
  final Image image;

  Cuisine(this.id, this.title, this.image);

  factory Cuisine.fromJson(Map<String, dynamic> json) =>
      _$CuisineFromJson(json);

  Map<String, dynamic> toJson() => _$CuisineToJson(this);
}

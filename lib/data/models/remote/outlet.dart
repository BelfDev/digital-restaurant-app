import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/data/models/remote/image.dart';
import 'package:dr_app/data/models/remote/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'outlet.g.dart';

/// A representation of the Outlet entity.
@JsonSerializable()
class Outlet {
  final int id;
  final String title;
  final double rating;
  final int priceLevel;
  final Cuisine cuisine;
  final Location location;
  final List<Image> images;

  Outlet(this.id, this.title, this.rating, this.priceLevel, this.cuisine,
      this.images, this.location);

  static Outlet fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);

  Map<String, dynamic> toJson() => _$OutletToJson(this);
}

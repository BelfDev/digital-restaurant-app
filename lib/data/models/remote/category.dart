import 'package:dr_app/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// A representation of the Category entity.
@JsonSerializable()
class Category extends Equatable {
  final String title;
  final Image image;

  const Category(
    this.title,
    this.image,
  );

  static Category fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object> get props => [title];
}

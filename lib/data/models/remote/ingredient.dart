import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'ingredient.g.dart';

/// A representation of the Ingredient entity.
@JsonSerializable()
class Ingredient extends Equatable {
  final String title;
  final Image image;

  const Ingredient(
    this.title,
    this.image,
  );

  static Ingredient fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  @override
  List<Object> get props => [title];
}

import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/models/remote/category.dart';
import 'package:dr_app/data/models/remote/ingredient.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

/// A representation of the Product entity.
@JsonSerializable()
class Product extends Equatable {
  final int id;
  final String title;
  final double unitPrice;
  final String description;
  final int quantity;
  final double preparationTime;
  final List<Image> images;
  final List<Ingredient> ingredients;
  final List<Category> categories;

  const Product(
    this.id,
    this.title,
    this.unitPrice,
    this.description,
    this.preparationTime,
    this.images,
    this.ingredients,
    this.categories,
    this.quantity,
  );

  static Product fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object> get props => [
        id,
        title,
        unitPrice,
        description,
        preparationTime,
        ingredients,
        categories,
      ];
}

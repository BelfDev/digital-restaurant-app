import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

/// Customised [SmoothStarRating] to convey the overall acceptance
/// of outlets or dishes by customers.
class LUStarRating extends StatelessWidget {
  final double rating;
  final Color starColor;
  final Color borderColor;
  final EdgeInsetsGeometry margin;

  const LUStarRating(
      {Key key,
      @required this.rating,
      this.starColor = LUColors.yellow,
      this.borderColor = LUColors.yellow,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SmoothStarRating(
          filledIconData: FontAwesome.star,
          defaultIconData: FontAwesome.star_o,
          halfFilledIconData: FontAwesome.star_half_full,
          allowHalfRating: true,
          starCount: 5,
          rating: rating ?? 0,
          size: 16.0,
          isReadOnly: true,
          color: starColor,
          borderColor: borderColor,
          spacing: 2.0),
    );
  }
}

import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../gradient_filter.dart';
import 'base_card.dart';

class LUOutletCard extends StatelessWidget {
  static const _imageBorderRadius = 10.0;

  final double width;
  final double height;
  final Function onPressed;
  final EdgeInsetsGeometry margin;
  final List<Color> filterColors;
  final double rating;
  final Color starColor;
  final String title;
  final String priceRange;

  const LUOutletCard(
      {Key key,
      this.width,
      this.height = 128,
      this.onPressed,
      this.margin = const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      this.filterColors,
      this.rating,
      this.starColor = Colors.yellow,
      @required this.title,
      this.priceRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      height: height,
      margin: margin,
      padding: EdgeInsets.all(8.0),
      borderRadius: 10.0,
      onPressed: onPressed,
      children: <Widget>[
        Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_imageBorderRadius),
              color: Colors.blueGrey),
        ),
        LUGradientFilter(
            filterColors: filterColors,
            borderRadius: BorderRadius.circular(_imageBorderRadius)),
        _buildCardContent()
      ],
    );
  }

  Container _buildCardContent() => Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: rating ?? 0,
                size: 16.0,
                isReadOnly: true,
                color: starColor,
                borderColor: starColor,
                spacing: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, style: Styles.cardTitle),
                Text(
                  priceRange,
                  style: Styles.cardPriceRange,
                )
              ],
            )
          ],
        ),
      );
}

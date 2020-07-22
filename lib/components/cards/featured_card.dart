import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

import '../gradient_filter.dart';

class LUFeaturedCard extends StatelessWidget {
  final double width;
  final double height;
  final String imageSrc;
  final Function onPressed;
  final double borderRadius;
  final List<Color> filterColors;
  final double padding;
  final double rating;
  final Color starColor;
  final String title;
  final String subtitle;
  final String priceRange;

  const LUFeaturedCard({
    @required this.title,
    @required this.subtitle,
    @required this.priceRange,
    this.width = 202,
    this.height = 232,
    this.onPressed,
    this.imageSrc,
    this.borderRadius = 12.0,
    this.filterColors,
    this.padding = 8.0,
    this.rating,
    this.starColor = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      height: height,
      borderRadius: borderRadius,
      onPressed: onPressed,
      children: <Widget>[
        Positioned.fill(
            child: FadeInImage.assetNetwork(
          placeholder: 'res/images/restaurant-placeholder.png',
          image: imageSrc,
          fit: BoxFit.fill,
        )),
        Positioned.fill(child: LUGradientFilter(filterColors: filterColors)),
        Positioned.fill(child: _buildCardContent()),
      ],
    );
  }

  Container _buildCardContent() => Container(
        margin: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LUStarRating(rating: rating ?? 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  subtitle,
                  style: Styles.cardSubtitle,
                ),
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

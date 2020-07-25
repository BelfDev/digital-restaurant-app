import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/images.dart';
import 'package:flutter/material.dart';

import '../gradient_filter.dart';
import 'base_card.dart';

/// A material [Card] used to display information about an [Outlet].
///
class LUOutletCard extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final EdgeInsetsGeometry margin;
  final List<Color> filterColors;
  final double rating;
  final Color starColor;
  final String title;
  final String priceRange;
  final String imageSrc;

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
      @required this.priceRange,
      this.imageSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      height: height,
      margin: margin,
      padding: EdgeInsets.all(8.0),
      onPressed: onPressed,
      children: <Widget>[
        Positioned.fill(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(LUTheme.cardBorderRadius - 4),
          child: FadeInImage.assetNetwork(
            placeholder: Images.verticalPlaceholder,
            image: imageSrc,
            fit: BoxFit.cover,
          ),
        )),
        LUGradientFilter(
            filterColors: filterColors,
            borderRadius: BorderRadius.circular(LUTheme.cardBorderRadius - 4)),
        _buildCardContent(context)
      ],
    );
  }

  Container _buildCardContent(context) => Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LUStarRating(
              rating: rating ?? 0,
              margin: EdgeInsets.only(bottom: 2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, style: LUTheme.of(context).textTheme.headline5),
                Text(
                  priceRange,
                  style: LUTheme.of(context).textTheme.bodyText1,
                )
              ],
            )
          ],
        ),
      );
}

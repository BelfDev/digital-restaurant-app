import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/images.dart';
import 'package:flutter/material.dart';

import '../gradient_filter.dart';

/// A material [Card] used to display information featured [Outlet]s or [Product]s.
/// Note: if a price is given, the widget favors a [Product] format.
class LUFeaturedCard extends StatelessWidget {
  final double width;
  final double height;
  final String imageSrc;
  final Function onPressed;
  final double borderRadius;
  final List<Color> filterColors;
  final double padding;
  final double rating;
  final String title;
  final String subtitle;
  final int priceRange;
  final String price;

  const LUFeaturedCard({
    @required this.title,
    @required this.priceRange,
    this.width = 202,
    this.height = 232,
    this.onPressed,
    this.imageSrc,
    this.borderRadius,
    this.filterColors,
    this.padding = 8.0,
    this.rating,
    this.price,
    this.subtitle,
  }) : assert(price != null || subtitle != null);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      height: height,
      onPressed: onPressed,
      children: <Widget>[
        Positioned.fill(
            child: FadeInImage.assetNetwork(
          placeholder: Images.verticalPlaceholder,
          image: imageSrc,
          fit: BoxFit.fill,
        )),
        Positioned.fill(child: LUGradientFilter(filterColors: filterColors)),
        Positioned.fill(child: _buildCardContent(context)),
      ],
    );
  }

  Container _buildCardContent(context) => Container(
        margin: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            price != null
                ? SizedBox()
                : LUStarRating(
                    rating: rating ?? 0, margin: EdgeInsets.only(bottom: 2)),
            price != null
                ? SizedBox()
                : Text(
                    title,
                    style: LUTheme.of(context).textTheme.headline5,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                    price != null ? title : subtitle,
                    style: price != null
                        ? LUTheme.of(context).textTheme.headline5
                        : LUTheme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  price ?? List.generate(priceRange, (index) => "\$").join(),
                  style: LUTheme.of(context).textTheme.bodyText1,
                )
              ],
            )
          ],
        ),
      );
}

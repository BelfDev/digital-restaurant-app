import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A material [Card] used to display information about a cuisine category.
///
class LUCategoryCard extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final String imageSrc;
  final String title;
  final EdgeInsetsGeometry margin;

  const LUCategoryCard(
      {Key key,
      this.width = 136,
      this.height = 120,
      this.onPressed,
      this.imageSrc,
      this.title,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      height: height,
      margin: margin,
      onPressed: onPressed,
      childrenAlignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: Styles.categoryCardTitle,
            ),
            ClipRRect(
                borderRadius:
                    BorderRadius.circular(LUTheme.cardBorderRadius - 2),
                child: FadeInImage.assetNetwork(
                  width: width / 1.5,
                  height: height / 1.5,
                  placeholder: 'res/images/restaurant-placeholder.png',
                  image: imageSrc,
                  fit: BoxFit.fill,
                )),
          ],
        )
      ],
    );
  }
}

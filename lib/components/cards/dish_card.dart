import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class LUDishCard extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final String imageSrc;

  const LUDishCard(
      {Key key,
      this.width,
      this.height = 128,
      this.margin = const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      this.imageSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      height: height,
      margin: margin,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.verticalPlaceholder,
                    image: imageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pad Thai Noodles',
                      style: LUTheme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: LUColors.darkBlue),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        'Classic Thai Street Food Dish With Rice Noodles & Roasted Peanuts',
                        style: Styles.dishCardDescription,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.watch_later,
                              color: LUColors.smoothGray,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '12 min',
                              style: Styles.dishCardPreparation,
                            )
                          ],
                        ),
                        Text(
                          '£ 8.50',
                          style: Styles.dishCardPriceTag,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

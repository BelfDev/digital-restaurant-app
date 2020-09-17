import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

import '../status_label.dart';

class LUProductCard extends StatelessWidget {
  const LUProductCard(
      {Key key,
      this.width,
      this.height = 128,
      this.margin = const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      this.imageSrc,
      this.title,
      this.description,
      this.priceTag,
      this.quantity,
      this.preparationTime,
      this.shrink = false,
      this.showStatus = false,
      this.onPressed})
      : super(key: key);

  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final String imageSrc;
  final String title;
  final String description;
  final String priceTag;
  final int quantity;
  final double preparationTime;
  final bool shrink;
  final bool showStatus;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: 100,
      height: height,
      margin: margin,
      onPressed: onPressed,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Stack(
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          height: double.infinity,
                          width: double.infinity,
                          placeholder: Images.verticalPlaceholder,
                          image: imageSrc ?? '',
                          fit: BoxFit.cover,
                        ),
                        if (showStatus)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: LUStatusLabel(text: 'preparing'),
                          )
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: shrink ? 3 : 2,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: LUTheme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: LUColors.darkBlue),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Styles.dishCardDescription,
                      ),
                    ),
                    SizedBox(height: 4),
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
                              '$preparationTime min',
                              style: Styles.dishCardPreparation,
                            )
                          ],
                        ),
                        buildPriceTag(context)
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

  Widget buildPriceTag(context) {
    return quantity != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("${quantity}x",
                  style: Styles.dishCardPreparation
                      .copyWith(color: LUTheme.of(context).accentColor)),
              SizedBox(
                width: 4,
              ),
              Text(
                priceTag,
                style: Styles.dishCardPriceTag,
              )
            ],
          )
        : Text(
            priceTag,
            style: Styles.dishCardPriceTag,
          );
  }
}

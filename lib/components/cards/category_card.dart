import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class LUCategoryCard extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final String imageSrc;
  final String title;

  const LUCategoryCard(
      {Key key,
      this.width = 120,
      this.height = 120,
      this.onPressed,
      this.imageSrc,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      height: height,
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
              borderRadius: BorderRadius.circular(10.0),
//              child: Image.network(
//                imageSrc,
//                fit: BoxFit.fill,
//              ),
              child: Container(
                width: width / 2,
                height: width / 2,
                color: Colors.blue,
              ),
            )
          ],
        )
      ],
    );
  }
}

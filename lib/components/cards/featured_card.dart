import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class LUFeaturedCard extends StatelessWidget {
  final double width;
  final double height;
  final String imageSrc;
  final Function onPressed;

  const LUFeaturedCard(
      {this.width = 184, this.height = 232, this.onPressed, this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        )),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.network(
                imageSrc,
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(child: _buildCardContent()),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
              ),
            ))
          ],
        ),
      ),
    );
  }

  Container _buildCardContent() => Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SmoothStarRating(
                allowHalfRating: false,
                starCount: 5,
                rating: 4,
                size: 16.0,
                isReadOnly: true,
                color: Colors.yellow,
                borderColor: Colors.yellow,
                spacing: 0.0),
            Text('Bar Soba',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Asian Food',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$\$',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      );
}

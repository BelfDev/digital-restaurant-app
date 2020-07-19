import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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

  const LUFeaturedCard(
      {this.width = 184,
      this.height = 232,
      this.onPressed,
      this.imageSrc,
      this.borderRadius = 12.0,
      this.filterColors,
      this.padding = 8.0,
      this.rating,
      this.starColor = Colors.yellow,
      @required this.title,
      this.subtitle,
      this.priceRange});

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
          Radius.circular(borderRadius),
        )),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
//              child: Image.network(
//                imageSrc,
//                fit: BoxFit.fill,
//              ),
                child: Ink(
              color: Colors.grey,
            )),
            Positioned.fill(child: _buildImageFilter()),
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

  Container _buildImageFilter() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: filterColors ??
                    [Colors.transparent, Colors.black.withOpacity(0.8)])),
      );

  Container _buildCardContent() => Container(
        margin: EdgeInsets.all(padding),
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
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  subtitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  priceRange,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      );
}

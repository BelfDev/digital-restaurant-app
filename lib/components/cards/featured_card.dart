import 'package:flutter/material.dart';

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
            Positioned.fill(
                child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('* * * * *'),
                  Text('Bar Soba'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('Asian Food'), Text('\$\$')],
                  )
                ],
              ),
            )),
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
}

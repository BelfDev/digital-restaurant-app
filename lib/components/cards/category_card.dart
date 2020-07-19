import 'package:dr_app/components/cards/base_card.dart';
import 'package:flutter/material.dart';

class LUCategoryCard extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;

  const LUCategoryCard(
      {Key key, this.width = 120, this.height = 120, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      height: height,
      onPressed: onPressed,
      children: <Widget>[Text('Hi')],
    );
  }
}

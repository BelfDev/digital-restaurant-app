import 'package:flutter/material.dart';

import 'base_card.dart';

class LUOutletCard extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final EdgeInsetsGeometry margin;

  const LUOutletCard(
      {Key key,
      this.width,
      this.height = 128,
      this.onPressed,
      this.margin = const EdgeInsets.symmetric(vertical: 0, horizontal: 16)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      height: height,
      borderRadius: 10.0,
      margin: margin,
      children: <Widget>[
        Ink(
          color: Colors.blueGrey,
        )
      ],
    );
  }
}

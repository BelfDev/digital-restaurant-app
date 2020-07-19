import 'package:flutter/material.dart';

class LUBaseCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;

  const LUBaseCard(
      {Key key,
      @required this.child,
      this.width,
      this.height,
      this.borderRadius})
      : super(key: key);

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
          child: child,
        ));
  }
}

import 'package:flutter/material.dart';

/// A container for Lutick buttons composition.
///
///
class LUBaseButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry margin;

  LUBaseButton({
    @required this.width,
    @required this.height,
    @required this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      margin: margin,
    );
  }
}

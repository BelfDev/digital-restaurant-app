import 'package:flutter/material.dart';

/// A container for Lutick buttons composition.
///
///
class LUBaseButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  LUBaseButton({
    @required this.width,
    @required this.height,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
    );
  }
}

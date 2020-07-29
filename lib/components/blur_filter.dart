import 'dart:ui';

import 'package:flutter/material.dart';

/// A semi-transparent backdrop layer that casts the blur
/// effect of the views below it.
class LUBlurFilter extends StatelessWidget {
  final Widget child;
  final double blurIntensity;
  final Color color;

  const LUBlurFilter({Key key, this.child, this.blurIntensity, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterColor =
        color?.withOpacity(0.5) ?? Colors.grey.shade200.withOpacity(0.5);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
      child: Container(
          height: 24.0,
          decoration: BoxDecoration(color: filterColor),
          child: child),
    );
  }
}

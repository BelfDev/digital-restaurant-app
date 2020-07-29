import 'dart:ui';

import 'package:flutter/material.dart';

/// A semi-transparent backdrop layer that casts the blur
/// effect of the views below it.
class LUBlurFilter extends StatelessWidget {
  final Widget child;
  final double blurIntensity;

  const LUBlurFilter({Key key, this.child, this.blurIntensity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
      child: Container(
          height: 24.0,
          decoration:
              new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
          child: child),
    );
  }
}

import 'package:flutter/material.dart';

/// A graphic layer which applies a semi-transparent gradient to an image.
/// This widget is meant to be used in a [Stack].
class LUGradientFilter extends StatelessWidget {
  final List<Color> filterColors;
  final BorderRadiusGeometry borderRadius;

  const LUGradientFilter({
    Key key,
    @required this.filterColors,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: filterColors ??
                  [Colors.transparent, Colors.black.withOpacity(0.6)])),
    );
  }
}

import 'package:flutter/material.dart';

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

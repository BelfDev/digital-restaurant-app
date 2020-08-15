import 'package:flutter/material.dart';

/// A [SizedBox] that contains a [CircularProgressIndicator]
class LULoadingPlaceholder extends StatelessWidget {
  final double height, width;

  const LULoadingPlaceholder({Key key, this.height = 100.0, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: Center(child: CircularProgressIndicator()));
  }
}

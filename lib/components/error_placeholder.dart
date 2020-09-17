import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// A [SizedBox] that contains a centered [Icon]
/// indicating an error has occurred.
class LUErrorPlaceholder extends StatelessWidget {
  final double height, width;
  final String message;

  const LUErrorPlaceholder(
      {Key key,
      this.height = 100.0,
      this.width,
      this.message = "Error loading content"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 48,
              color: LUTheme.of(context).disabledColor,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              message,
              style: LUTheme.of(context).textTheme.headline6.copyWith(
                    color: LUTheme.of(context).disabledColor,
                  ),
            )
          ],
        )));
  }
}

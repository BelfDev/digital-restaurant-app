import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// A [SizedBox] that contains a centered [Icon]
/// indicating that no content was found.
class LUEmptyContentPlaceholder extends StatelessWidget {
  final double height, width;
  final String message;

  const LUEmptyContentPlaceholder(
      {Key key,
      this.height = 100.0,
      this.width,
      this.message = "Sorry, nothing was found"})
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
              Ionicons.md_sad,
              size: 80,
              color: LUTheme.of(context).disabledColor,
            ),
            SizedBox(
              height: 16,
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

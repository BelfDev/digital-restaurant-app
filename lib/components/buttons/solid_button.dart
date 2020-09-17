import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

import 'base_button.dart';

/// A customized Material Design "raised button"
///
/// A raised button is based on a [Material] widget whose [Material.elevation]
/// increases when the button is pressed.
///
/// Use raised buttons to add dimension to otherwise mostly flat layouts, e.g.
/// in long busy lists of content, or in wide spaces. Avoid using raised buttons
/// on already-raised content such as dialogs or cards.
///
class LUSolidButton extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  final String title;
  final Color color;
  final VoidCallback onPressed;
  final bool uppercase;

  LUSolidButton(
      {Key key,
      this.width = 280.0,
      this.height = 56.0,
      this.title,
      this.onPressed,
      this.color,
      this.margin,
      this.uppercase = true});

  @override
  Widget build(BuildContext context) {
    return LUBaseButton(
        width: width,
        height: height,
        margin: margin,
        child: RaisedButton(
            onPressed: onPressed,
            disabledColor: Colors.grey.shade500.withOpacity(0.35),
            color: color,
            child: Text(
              uppercase ? title.toUpperCase() : title,
              style: LUTheme.of(context).textTheme.button,
            )));
  }
}

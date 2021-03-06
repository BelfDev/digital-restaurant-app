import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

import 'base_button.dart';

/// A customized Material Design "outline button"
///
/// Similar to a [FlatButton] with a thin grey rounded rectangle border.
///
/// Use outline buttons for actions with less emphasis. They useful when
/// a layout also holds a LUSolidButton.
///
class LUOutlineButton extends StatelessWidget {
  final double width;
  final double height;

  final Function onPressed;
  final String title;
  final Color borderColor;

  LUOutlineButton(
      {this.width = 280.0,
      this.height = 56.0,
      this.title,
      this.onPressed,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    final borderColor = this.borderColor ?? LUTheme.of(context).primaryColor;
    return LUBaseButton(
      width: width,
      height: height,
      child: OutlineButton(
        onPressed: onPressed,
        textColor: borderColor,
        highlightedBorderColor: borderColor,
        borderSide: BorderSide(width: 2, color: borderColor),
        child: Text(
          title.toUpperCase(),
          style: LUTheme.of(context)
              .textTheme
              .button
              .copyWith(color: LUTheme.of(context).primaryColor),
        ),
      ),
    );
  }
}

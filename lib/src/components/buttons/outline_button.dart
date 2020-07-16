import 'package:dr_app/src/components/buttons/base_button.dart';
import 'package:flutter/material.dart';

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
      this.borderColor = const Color(0xFF4F5D75)});

  @override
  Widget build(BuildContext context) {
    return LUBaseButton(
      width: width,
      height: height,
      child: OutlineButton(
        onPressed: onPressed,
        textColor: borderColor,
        highlightedBorderColor: borderColor,
        borderSide: BorderSide(width: 2, color: borderColor),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

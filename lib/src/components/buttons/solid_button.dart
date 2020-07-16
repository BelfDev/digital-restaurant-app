import 'package:dr_app/src/components/buttons/base_button.dart';
import 'package:flutter/material.dart';

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

  final String title;
  final Color color;
  final Function onPressed;

  LUSolidButton(
      {this.width = 280.0,
      this.height = 56.0,
      this.title,
      this.onPressed,
      this.color = const Color(0xFFEF8354)});

  @override
  Widget build(BuildContext context) {
    return LUBaseButton(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

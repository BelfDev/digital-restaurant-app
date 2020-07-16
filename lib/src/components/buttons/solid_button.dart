import 'package:dr_app/src/components/buttons/base_button.dart';
import 'package:flutter/material.dart';

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

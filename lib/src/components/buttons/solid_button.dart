import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final double width;
  final double height;

  final String title;
  final Color color;
  final Function onPressed;

  SolidButton(
      {this.width = 280.0,
      this.height = 56.0,
      this.title,
      this.onPressed,
      this.color = const Color(0xFFEF8354)});

  @override
  Widget build(BuildContext context) {
    return Container(
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

import 'package:flutter/material.dart';

class LUIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color tint;
  final Color backgroundColor;

  LUIconButton(
      {@required this.icon,
      @required this.onPressed,
      this.tint = Colors.white,
      this.backgroundColor = const Color(0xFF4F5D75)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Icon(
          icon,
          color: tint,
        ),
      ),
    );
  }
}

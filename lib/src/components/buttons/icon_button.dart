import 'package:flutter/material.dart';

class LUIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final Color tint;
  final Color backgroundColor;

  LUIconButton(
      {@required this.icon,
      this.onPressed,
      this.tint = Colors.white,
      this.backgroundColor = const Color(0xFF4F5D75)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      child: Ink(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: IconButton(
          icon: icon,
          color: tint,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

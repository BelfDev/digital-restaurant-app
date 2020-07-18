import 'package:flutter/material.dart';

import 'base_button.dart';

/// A customized Material Design "icon button"
///
/// Looks similar to [RaisedButton] but supports an icon asset.
///
class LUIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;
  final Color tint;
  final Color backgroundColor;

  LUIconButton(
      {@required this.icon,
      @required this.onPressed,
      this.tint = Colors.white,
      this.backgroundColor = const Color(0xFF4F5D75),
      this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    return LUBaseButton(
      width: 56,
      height: 56,
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Icon(
          icon,
          color: tint,
          size: iconSize,
        ),
      ),
    );
  }
}
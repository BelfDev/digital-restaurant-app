import 'package:dr_app/components/buttons/base_button.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// Simple icon button commonly used as trailing items in
/// the [LUTileOptionCard] component.
class LUTileButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final IconData icon;
  final VoidCallback onPressed;
  final Color tint;

  const LUTileButton(
      {Key key,
      this.width,
      this.height,
      this.margin,
      this.icon,
      this.child,
      this.onPressed,
      this.tint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseButton(
      width: 40,
      height: 48,
      margin: margin,
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          size: 24.0,
          color: tint ?? LUTheme.of(context).primaryColor,
        ),
        padding: EdgeInsets.all(12.0),
        shape: CircleBorder(),
      ),
    );
  }
}

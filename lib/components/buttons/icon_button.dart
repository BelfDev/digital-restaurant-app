import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

import 'base_button.dart';

/// A customized Material Design "icon button"
///
/// Looks similar to [RaisedButton] but supports an icon asset.
///
class LUIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;
  final Color tint;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  LUIconButton(
      {@required this.icon,
      @required this.onPressed,
      this.tint,
      this.backgroundColor,
      this.iconSize,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return LUBaseButton(
      width: 56,
      height: 56,
      child: RawMaterialButton(
          onPressed: onPressed,
          fillColor: backgroundColor ?? LUTheme.of(context).primaryColor,
          shape: LUTheme.of(context).buttonTheme.shape,
          child: padding != null
              ? Padding(padding: padding, child: _buildIcon(context))
              : _buildIcon(context)),
    );
  }

  _buildIcon(context) => Icon(
        icon,
        color: tint ?? LUTheme.of(context).primaryIconTheme.color,
        size: iconSize ?? LUTheme.of(context).primaryIconTheme.size,
      );
}

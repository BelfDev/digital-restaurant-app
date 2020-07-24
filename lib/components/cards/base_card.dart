import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// Customized [Card] card used for Lutick card composition
///
class LUBaseCard extends StatelessWidget {
  final List<Widget> children;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Function onPressed;
  final AlignmentGeometry childrenAlignment;

  const LUBaseCard(
      {Key key,
      @required this.children,
      this.width,
      this.height,
      this.borderRadius = 12.0,
      this.onPressed,
      this.childrenAlignment = AlignmentDirectional.topStart,
      this.margin = const EdgeInsets.all(4.0),
      this.padding = const EdgeInsets.all(0.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Card(
          elevation: LUTheme.of(context).cardTheme.elevation,
          margin: margin,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: LUTheme.of(context).cardTheme.shape,
          child: Padding(
            padding: padding,
            child: Stack(
              alignment: childrenAlignment,
              children: <Widget>[
                ...children,
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}

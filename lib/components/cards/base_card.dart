import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// Customized [Card] card used for Lutick card composition
///
class LUBaseCard extends StatelessWidget {
  final List<Widget> children;
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Function onPressed;
  final AlignmentGeometry childrenAlignment;
  final ShapeBorder shape;
  final Color backgroundColor;
  final double elevation;

  const LUBaseCard({
    Key key,
    this.children,
    this.width,
    this.height,
    this.onPressed,
    this.childrenAlignment = AlignmentDirectional.topStart,
    this.margin = const EdgeInsets.all(4.0),
    this.padding = const EdgeInsets.all(0.0),
    this.child,
    this.shape,
    this.backgroundColor,
    this.elevation,
  })  : assert(child == null || children == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Card(
          elevation: elevation ?? LUTheme.of(context).cardTheme.elevation,
          margin: margin,
          color: backgroundColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: shape ?? LUTheme.of(context).cardTheme.shape,
          child: child ??
              Padding(
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

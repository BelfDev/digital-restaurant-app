import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A custom material [Container] with rounded top borders.
class RoundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  RoundContainer(
      {@required this.child,
      this.margin =
          const EdgeInsets.only(top: Styles.roundContainerHeight - 40),
      this.padding = const EdgeInsets.only(top: 16)});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: margin,
        child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: LUTheme.of(context).backgroundColor,
              borderRadius: Styles.roundContainerBorderRadius,
            ),
            child: child));
  }
}

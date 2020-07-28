import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

/// A button which slides to the right to trigger an action
///
/// Use slider buttons for decisive actions such as "check-in" or "check-out".
///
class LUSliderButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final VoidCallback onSlided;

  final Color trackColor;
  final Color labelColor;
  final Color buttonColor;
  final EdgeInsetsGeometry margin;

  LUSliderButton({
    Key key,
    this.width = 288.0,
    this.height = 72.0,
    @required this.title,
    @required this.onSlided,
    this.trackColor = LUColors.smoothGray,
    this.labelColor = LUColors.gray,
    this.buttonColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ConfirmationSlider(
        width: width,
        height: height,
        text: title.toUpperCase(),
        onConfirmation: onSlided,
        backgroundShape: BorderRadius.circular(LUTheme.buttonBorderRadius),
        backgroundColor:
            trackColor ?? LUTheme.of(context).unselectedWidgetColor,
        foregroundColor: buttonColor ?? LUTheme.of(context).buttonColor,
        foregroundShape: BorderRadius.circular(LUTheme.buttonBorderRadius),
        icon: FontAwesome5Solid.hand_point_right,
        iconColor: LUTheme.of(context).backgroundColor,
        textStyle: LUTheme.of(context)
            .textTheme
            .button
            .copyWith(color: labelColor ?? LUColors.gray),
      ),
    );
  }
}

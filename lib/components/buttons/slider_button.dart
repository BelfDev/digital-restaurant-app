import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

/// A button which slides to the right to trigger an action
///
/// Use slider buttons for decisive actions such as "check-in" or "check-out".
///
class LUSliderButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Function onSlided;

  final Color trackColor;
  final Color labelColor;
  final Color shimmerColor;
  final Color buttonColor;
  final String semanticTitle;

  LUSliderButton({
    this.width = 280.0,
    this.height = 72.0,
    this.title,
    @required this.onSlided,
    this.trackColor = LUColors.smoothGray,
    this.labelColor = LUColors.gray,
    this.shimmerColor = LUColors.smoothWhite,
    this.buttonColor,
    this.semanticTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliderButton(
      width: width,
      height: height,
      radius: LUTheme.buttonBorderRadius,
      backgroundColor: trackColor,
      action: onSlided,
      label: Text(
        title?.toUpperCase(),
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      baseColor: labelColor,
      highlightedColor: shimmerColor,
      buttonColor: buttonColor ?? LUTheme.of(context).buttonColor,
      vibrationFlag: false,
      icon: Center(
          child: Icon(
        Icons.store,
        color: Colors.white,
        size: 32,
        semanticLabel: semanticTitle,
      )),
      dismissible: false,
      buttonSize: 56,
    );
  }
}

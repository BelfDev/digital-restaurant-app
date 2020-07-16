import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class LUSliderButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color color;
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
    this.color,
    @required this.onSlided,
    this.trackColor = const Color(0xFFE3E3E3),
    this.labelColor = const Color(0xCC969696),
    this.shimmerColor = const Color(0xFFFAFAFA),
    this.buttonColor = const Color(0xFFEF8354),
    this.semanticTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliderButton(
      width: width,
      height: height,
      radius: 12,
      backgroundColor: trackColor,
      action: onSlided,
      label: Text(
        title?.toUpperCase(),
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      baseColor: labelColor,
      highlightedColor: shimmerColor,
      buttonColor: buttonColor,
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

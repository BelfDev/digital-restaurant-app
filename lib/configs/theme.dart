import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LUTheme {
  static const double buttonBorderRadius = 12;
  static const double iconSize = 32;

  static ThemeData of(context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
        primaryColor: LUColors.navyBlue,
        accentColor: LUColors.orange,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
        backgroundColor: LUColors.smoothWhite,
        dividerColor: Colors.transparent,
        buttonColor: LUColors.orange,
        primaryIconTheme:
            IconThemeData(color: LUColors.smoothWhite, size: iconSize),
        buttonTheme: baseTheme.buttonTheme.copyWith(
          buttonColor: LUColors.orange,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius)),
        ));
  }
}

import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LUTheme {
  static ThemeData of(context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
        primaryColor: LUColors.navyBlue,
        accentColor: LUColors.orange,
        bottomAppBarColor: Colors.white,
        backgroundColor: LUColors.smoothWhite,
        dividerColor: Colors.transparent,
        buttonColor: LUColors.orange,
        buttonTheme: baseTheme.buttonTheme.copyWith(
          buttonColor: LUColors.orange,
        ));
  }
}

import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class LUTheme {
  static const double buttonBorderRadius = 12;
  static const double primaryIconSize = 32;
  static const double bottomBarIconSize = 24;

  static ThemeData of(context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
        primaryColor: LUColors.navyBlue,
        accentColor: LUColors.orange,
        unselectedWidgetColor: LUColors.smoothGray,
        bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.white,
            shape: CircularNotchedRectangle(),
            elevation: 24.0),
        backgroundColor: LUColors.smoothWhite,
        dividerColor: Colors.transparent,
        buttonColor: LUColors.orange,
        primaryIconTheme:
            IconThemeData(color: LUColors.smoothWhite, size: primaryIconSize),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: LUColors.orange,
          elevation: 4.0,
        ),
        buttonTheme: baseTheme.buttonTheme.copyWith(
          buttonColor: LUColors.orange,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius)),
        ),
        textTheme: baseTheme.textTheme.copyWith(
            headline2: Styles.sloganTitleEmphasis,
            headline3: Styles.sloganTitle,
            button: Styles.button));
  }
}

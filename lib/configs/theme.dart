import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// This class encapsulates the ThemeData used to style
/// all the App components consistently.
class LUTheme {
  static const double buttonBorderRadius = 12.0;
  static const double primaryIconSize = 32.0;
  static const double bottomBarIconSize = 24.0;
  static const double cardBorderRadius = 12.0;

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
        cardTheme: baseTheme.cardTheme.copyWith(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(cardBorderRadius),
            )),
            elevation: 4.0),
        textTheme: baseTheme.textTheme.copyWith(
          headline2: Styles.sloganTitleEmphasis,
          headline3: Styles.sloganTitle,
          button: Styles.button,
          headline5: Styles.cardTitle,
          headline6: Styles.cardSubtitle,
          bodyText1: Styles.cardPriceRange,
          bodyText2: Styles.categoryCardTitle,
        ));
  }
}

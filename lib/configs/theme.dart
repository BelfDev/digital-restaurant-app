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
  static const double bottomSheetRadius = 12.0;

  static ThemeData of(context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
        primaryColor: LUColors.navyBlue,
        accentColor: LUColors.orange,
        unselectedWidgetColor: LUColors.smoothGray,
        bottomAppBarTheme: BottomAppBarTheme(
            color: LUColors.white,
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
          // fontSize: 32
          headline1: Styles.productTitle,
          // fontSize: 36
          headline2: Styles.sloganTitleEmphasis,
          // fontSize: 28
          headline3: Styles.sloganTitle,
          // fontSize: 18
          button: Styles.button,
          // fontSize: 24
          headline5: Styles.cardTitle,
          // fontSize: 22
          headline6: Styles.cardSubtitle,
          // fontSize: 18
          bodyText1: Styles.cardPriceRange,
          // fontSize: 16
          bodyText2: Styles.categoryCardTitle,
        ));
  }
}

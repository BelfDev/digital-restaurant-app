import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

/// An abstract class holding the most commonly reused component styles.
abstract class Styles {
  ///  Slogan Styles
  // headline2
  static const sloganTitleEmphasis = TextStyle(
      color: LUColors.navyBlue,
      fontSize: 36,
      height: 1.0,
      fontFamily: 'Lora',
      fontWeight: FontWeight.w700);

  // headline3
  static const sloganTitle = TextStyle(
      color: LUColors.navyBlue, fontSize: 28, height: 0.5, fontFamily: 'Lora');

  ///  Card Styles
  // headline5
  static const cardTitle = TextStyle(
      color: LUColors.smoothWhite, fontSize: 24, fontWeight: FontWeight.w600);

  // headline6
  static const cardSubtitle = TextStyle(
      color: LUColors.smoothWhite, fontSize: 22, fontWeight: FontWeight.w400);

  // bodyText1
  static const cardPriceRange = TextStyle(
      color: LUColors.smoothWhite, fontSize: 18, fontWeight: FontWeight.w400);

  //bodyText2
  static const categoryCardTitle = TextStyle(
      color: LUColors.darkBlue, fontSize: 16, fontWeight: FontWeight.w200);

  static const dishCardDescription = TextStyle(
      color: LUColors.darkBlue, fontSize: 12, fontWeight: FontWeight.w400);

  static const dishCardPriceTag = TextStyle(
      color: LUColors.darkBlue, fontSize: 18, fontWeight: FontWeight.w400);

  static const dishCardPreparation = TextStyle(
      color: LUColors.smoothGray, fontSize: 14, fontWeight: FontWeight.w400);

  static const dishStatusText = TextStyle(
      fontSize: 12, color: LUColors.darkBlue, fontWeight: FontWeight.w600);

  ///  Button Styles
  // button
  static const button =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600);
  static const fixedButtonMargin =
      EdgeInsets.only(left: 32, right: 32, bottom: 40);

  /// Text Styles
  static const sectionText = TextStyle(
      color: LUColors.darkBlue, fontSize: 17, fontWeight: FontWeight.w600);
  static const locationText = TextStyle(
      color: LUColors.darkBlue, fontSize: 17, fontWeight: FontWeight.w200);
  static const descriptionText =
      TextStyle(color: LUColors.darkBlue, fontSize: 14);
  static const productTitle = TextStyle(
      color: LUColors.darkBlue, fontSize: 32, fontWeight: FontWeight.bold);
  static const productSubtitle = TextStyle(color: LUColors.gray, fontSize: 17);
  static const outletSubtitle = TextStyle(
      color: LUColors.darkBlue, fontSize: 28, fontWeight: FontWeight.w200);
  static const chipText = TextStyle(
      fontSize: 13, fontWeight: FontWeight.w600, color: LUColors.smoothWhite);
  static const segmentControlText = TextStyle(
      fontSize: 14, color: LUColors.darkBlue, fontWeight: FontWeight.w600);
  static const bottomSheetTitle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: LUColors.darkBlue);
  static const topBarTitle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  static const tipLabel = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w400, color: LUColors.darkBlue);
  static const tipIncludedText = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: LUColors.darkBlue);
  static const homeCheckedHeaderTitle = TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: LUColors.smoothWhite,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.0, 2.0),
          blurRadius: 2.0,
          color: Colors.grey,
        )
      ]);

  static const homeCheckedHeaderSubtitle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w200,
      color: LUColors.smoothWhite,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.0, 2.0),
          blurRadius: 4.0,
          color: Colors.grey,
        )
      ]);
  static const profileTitle = TextStyle(
      color: LUColors.darkBlue, fontSize: 28, fontWeight: FontWeight.bold);
  static const profileButtonText = TextStyle(
      color: LUColors.darkYellow, fontSize: 17, fontWeight: FontWeight.w400);

  /// Container Styles
  static const roundBackgroundRadius = Radius.circular(40.0);
  static const double roundContainerHeight = 240;
  static const roundContainerBorderRadius = const BorderRadius.only(
      topLeft: roundBackgroundRadius, topRight: roundBackgroundRadius);
  static const double paginatedHeaderHeight = 400;
  static const double compactHeaderHeight = 240;

  /// List Styles
  static const sectionContentPadding =
      const EdgeInsets.only(left: 16, right: 16, bottom: 8);
  static const double categoryCarouselHeight = 160;
  static const double chipCarouselHeight = 56;
}

import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

/// An abstract class holding the most commonly reused component styles.
abstract class Styles {
  ///  Slogan Styles
  static const sloganTitleEmphasis = TextStyle(
      color: LUColors.navyBlue,
      fontSize: 36,
      height: 1.0,
      fontFamily: 'Lora',
      fontWeight: FontWeight.w700);

  static const sloganTitle = TextStyle(
      color: LUColors.navyBlue, fontSize: 28, height: 0.5, fontFamily: 'Lora');

  ///  Card Styles
  static const cardTitle = TextStyle(
      color: LUColors.smoothWhite, fontSize: 24, fontWeight: FontWeight.w600);

  static const cardSubtitle = TextStyle(
      color: LUColors.smoothWhite, fontSize: 22, fontWeight: FontWeight.w400);

  static const cardPriceRange = TextStyle(
      color: LUColors.smoothWhite, fontSize: 18, fontWeight: FontWeight.w400);

  static const categoryCardTitle = TextStyle(
      color: LUColors.darkBlue, fontSize: 16, fontWeight: FontWeight.w200);

  ///  Button Styles
  static const button =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600);

  /// Text Styles
  static const section = TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
}

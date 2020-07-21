import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const cardTitle = TextStyle(
      color: LUColors.smoothWhite, fontSize: 24, fontWeight: FontWeight.w600);

  static const cardSubtitle = TextStyle(
      color: LUColors.smoothWhite, fontSize: 22, fontWeight: FontWeight.w400);

  static const cardPriceRange = TextStyle(
      color: LUColors.smoothWhite, fontSize: 18, fontWeight: FontWeight.w400);

  static const categoryCardTitle = TextStyle(
      color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w400);
}

import 'dart:ui';

import 'package:dr_app/components/blur_filter.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A label indicating the dish preparation status.
/// This widget is meant to be used with [LUDishCard]s.
class LUStatusLabel extends StatelessWidget {
  final String text;

  const LUStatusLabel({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: LUBlurFilter(
            blurIntensity: 10.0,
            child: Center(
                child: Text(
              text.toUpperCase(),
              style: Styles.dishStatusText,
            )),
          )),
    );
  }
}

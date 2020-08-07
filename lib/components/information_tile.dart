import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// Simple customised container with a material [Text] widget in it.
class LUInformationTile extends StatelessWidget {
  final String text;

  const LUInformationTile({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56,
        decoration: BoxDecoration(
            color: LUColors.transparentLightGray,
            borderRadius: BorderRadius.circular(16.0)),
        child: Center(
            child: Text(
          text,
          style: Styles.informativeText.copyWith(color: LUColors.gray),
        )));
  }
}

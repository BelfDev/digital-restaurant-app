import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'buttons/icon_button.dart';

class LUTopBar extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final IconData icon;
  final Color tint;
  final Function onNavigationButtonPressed;

  const LUTopBar(
      {Key key,
      this.padding = const EdgeInsets.only(left: 16, right: 16, top: 8),
      this.icon = Icons.arrow_back_ios,
      this.tint = LUColors.navyBlue,
      @required this.onNavigationButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
          padding: padding,
          child: Row(
            children: <Widget>[
              LUIconButton(
                icon: icon,
                onPressed: onNavigationButtonPressed,
                tint: tint,
                backgroundColor: LUColors.smoothWhite,
              ),
            ],
          )),
    );
  }
}

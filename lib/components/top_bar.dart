import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

import 'buttons/icon_button.dart';

/// A top bar containing a set of titles and navigation buttons.
class LUTopBar extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final IconData icon;
  final Color tint;
  final String title;
  final Color buttonBackgroundColor;
  final Function onNavigationButtonPressed;
  final List<Widget> children;

  const LUTopBar(
      {Key key,
      this.padding = const EdgeInsets.only(left: 16, right: 16, top: 8),
      this.icon = Icons.arrow_back_ios,
      this.tint,
      this.onNavigationButtonPressed,
      this.children,
      this.buttonBackgroundColor,
      this.title})
      : assert(children == null || onNavigationButtonPressed == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
          padding: padding,
          child: Row(
              mainAxisAlignment: title != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children ??
                  <Widget>[
                    LUIconButton(
                      icon: icon,
                      onPressed: onNavigationButtonPressed,
                      tint: tint ?? LUTheme.of(context).primaryColor,
                      backgroundColor: buttonBackgroundColor ??
                          LUTheme.of(context).backgroundColor,
                    ),
                    title != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              title,
                              style: Styles.topBarTitle.copyWith(
                                  color: LUTheme.of(context).primaryColor),
                            ),
                          )
                        : SizedBox()
                  ])),
    );
  }
}

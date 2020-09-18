import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

import 'base_card.dart';

/// A customized material [Card] with a [ListTile] as its children.
/// This widget is often used as a compact [LUList] item.
class LUTileOptionCard extends StatelessWidget {
  final double width;
  final double height;
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final List<Widget> trailingChildren;
  final bool selected;
  final Color backgroundColor;
  final double elevation;
  final Color tint;

  const LUTileOptionCard({
    Key key,
    @required this.leadingIcon,
    @required this.title,
    this.width,
    this.height,
    this.onPressed,
    this.subtitle,
    this.trailingChildren,
    this.selected = false,
    this.backgroundColor,
    this.elevation,
    this.tint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      width: width,
      elevation: elevation,
      backgroundColor: backgroundColor,
      shape: selected
          ? new RoundedRectangleBorder(
              side: new BorderSide(
                  color: LUTheme.of(context).accentColor, width: 2.0),
              borderRadius:
                  BorderRadius.all(Radius.circular(LUTheme.cardBorderRadius)))
          : null,
      child: Center(
        child: ListTile(
          onTap: onPressed,
          dense: subtitle != null,
          selected: true,
          leading: Icon(
            leadingIcon,
            size: 32,
            color: tint ?? LUTheme.of(context).primaryColor,
          ),
          title: Text(
            title,
            style: Styles.optionTitleText
                .copyWith(color: tint ?? LUTheme.of(context).primaryColor),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: Styles.optionSubtitleText,
                )
              : null,
          trailing: trailingChildren != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: trailingChildren,
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: tint ?? LUTheme.of(context).primaryColor,
                ),
        ),
      ),
    );
  }
}

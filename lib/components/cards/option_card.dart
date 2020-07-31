import 'package:dr_app/components/cards/base_card.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A customized material [Card] with a [ListTile] as its children.
/// This widget is often used as a compact [LUList] item.
class LUOptionCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;

  const LUOptionCard(
      {Key key, @required this.leadingIcon, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      onPressed: () {},
      children: <Widget>[
        ListTile(
          leading: Icon(
            leadingIcon,
            size: 32,
            color: LUTheme.of(context).primaryColor,
          ),
          title: Text(
            title,
            style: Styles.optionTitleText
                .copyWith(color: LUTheme.of(context).primaryColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: LUTheme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

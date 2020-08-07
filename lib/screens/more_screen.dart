import 'package:dr_app/components/cards/tile_option_card.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// The More Screen allows the user to view additional
/// information about the App and configure some of its settings.
class MoreScreen extends StatelessWidget {
  static const id = 'more_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Text('More Settings',
              style: Styles.topBarTitle
                  .copyWith(color: LUTheme.of(context).primaryColor)),
        ),
        LUSection(
          titlePadding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          title: 'General',
          child: Column(
            children: <Widget>[
              LUTileOptionCard(
                  leadingIcon: FontAwesome5Solid.bell,
                  title: 'Notifications',
                  trailingChildren: <Widget>[
                    Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                      activeColor: LUTheme.of(context).accentColor,
                    ),
                  ]),
              LUTileOptionCard(
                  leadingIcon: FontAwesome5Solid.user_shield,
                  title: 'Terms and conditions',
                  onPressed: () {}),
              LUTileOptionCard(
                  leadingIcon: FontAwesome5Solid.star,
                  title: 'Rate the app',
                  onPressed: () {}),
              LUTileOptionCard(
                  leadingIcon: FontAwesome5Solid.info_circle,
                  title: 'About this version',
                  onPressed: () {}),
            ],
          ),
        )
      ],
    )));
  }
}

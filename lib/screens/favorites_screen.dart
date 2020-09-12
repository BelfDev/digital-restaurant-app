import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The favorite screen displays a list of restaurants
/// previously marked as "favorite" by the user.
class FavoritesScreen extends StatelessWidget {
  static const id = 'favorites_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            LUTopBar(
              title: 'Favorites',
              buttonBackgroundColor: LUTheme.of(context).primaryColor,
              tint: LUTheme.of(context).backgroundColor,
              onNavigationButtonPressed: () => Navigator.of(context).pop(),
              trailingButton: LUIconButton(
                  icon: Icons.tune,
                  onPressed: () {},
                  tint: LUTheme.of(context).backgroundColor,
                  backgroundColor: LUTheme.of(context).primaryColor),
            ),
            // LUList(
            //   padding: EdgeInsets.only(top: 40),
            //   nested: true,
            //   space: 10,
            //   items: _getOutletCards(context),
            // )
          ],
        ),
      ),
    );
  }
}

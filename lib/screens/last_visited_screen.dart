import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The LastVisitedScreen displays a list of all outlets
/// which the user has ever checked-in.
class LastVisitedScreen extends StatelessWidget {
  static const id = 'last_visited_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            LUTopBar(
              title: 'Last Visited',
              onNavigationButtonPressed: () => Navigator.of(context).pop(),
              buttonBackgroundColor: LUTheme.of(context).primaryColor,
              tint: LUTheme.of(context).backgroundColor,
            ),
            // LUSection(
            //   title: "Yesterday",
            //   margin: EdgeInsets.only(
            //     top: 40,
            //   ),
            //   builder: (_) => LUList(
            //     nested: true,
            //     space: 10,
            //     items: _getOutletCards(context),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

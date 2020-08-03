import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:flutter/material.dart';

import 'outlet_screen.dart';

class LastVisitedScreen extends StatelessWidget {
  static const id = 'last_visited_screen';

  List<Widget> _getOutletCards(context) => dummyOutlets
      .map((outlet) => LUOutletCard(
            imageSrc: outlet.imgSrc,
            rating: outlet.rating,
            title: outlet.name,
            priceRange: outlet.priceRange,
            onPressed: () {
              Navigator.of(context).pushNamed(OutletScreen.id,
                  arguments: ScreenArguments(
                      title: outlet.name, coverImgSrc: outlet.imgSrc));
            },
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: LUTheme.of(context).backgroundColor,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          LUTopBar(
            title: 'Last Visited',
            onNavigationButtonPressed: () => Navigator.of(context).pop(),
            buttonBackgroundColor: LUTheme.of(context).primaryColor,
            tint: LUTheme.of(context).backgroundColor,
          ),
          LUSection(
            title: "Yesterday",
            margin: EdgeInsets.only(
              top: 40,
            ),
            child: LUList(
              nested: true,
              space: 10,
              items: _getOutletCards(context),
            ),
          )
        ],
      ),
    ));
  }
}

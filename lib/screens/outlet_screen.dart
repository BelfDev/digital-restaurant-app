import 'package:dr_app/components/buttons/slider_button.dart';
import 'package:dr_app/components/cards/dish_card.dart';
import 'package:dr_app/components/chip_carousel.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/components/swiper.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class OutletScreen extends StatefulWidget {
  static const id = 'outlet_screen';

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  void _onBackButtonPressed() => Navigator.of(context).pop();

//  List<Widget> _getOutletCards() => dummyOutlets
//      .map((outlet) => LUOutletCard(
//            imageSrc: outlet.imgSrc,
//            rating: outlet.rating,
//            title: outlet.name,
//            priceRange: outlet.priceRange,
//            onPressed: () {},
//          ))
//      .toList();

  List<Widget> _getOutletCards() => dummyOutlets
      .map((outlet) => LUDishCard(
            imageSrc: outlet.imgSrc,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildHeader(args),
              buildContent(args),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 40.0,
              child: LUSliderButton(
                margin: Styles.fixedButtonMargin,
                title: 'Check-in',
                onSlided: () {},
              ))
        ],
      ),
    );
  }

  Widget buildHeader(ScreenArguments args) => Container(
        height: Styles.paginatedHeaderHeight,
        child: Stack(
          children: <Widget>[
            LUSwiper(imgSrcList: dummySwiperImages),
            LUTopBar(
              onNavigationButtonPressed: _onBackButtonPressed,
            ),
          ],
        ),
      );

  Widget buildContent(ScreenArguments args) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: Styles.sectionContentPadding.copyWith(top: 24, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bar Soba',
                  style: LUTheme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 2,
                ),
                Text('Asian Fusion Cuisine', style: Styles.outletSubtitle),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    LUStarRating(
                      margin: EdgeInsets.only(right: 8),
                      rating: 4,
                    ),
                    Text(
                      '\$\$',
                      style: LUTheme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: LUColors.darkBlue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          LUChipCarousel(
            items: dummyChipItems,
            onSelected: (value) {
              print(value);
            },
          ),
          LUList(
            padding: EdgeInsets.only(top: 16),
            nested: true,
            space: 10,
            items: _getOutletCards(),
          ),
        ],
      );
}

import 'dart:ui';

import 'package:dr_app/components/blur_filter.dart';
import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/cards/featured_card.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/outlet.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/screens/outlet_screen.dart';
import 'package:dr_app/screens/product_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'cuisine_screen.dart';

abstract class _HomeStyles {
  static const double headerHeight = 200;
  static const backgroundBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(40), topRight: Radius.circular(40));
  static const double featuredSectionHeight = 280;
}

enum _HomeMode { unchecked, checked }

/// The Home screen of the App. This screen has two main states: unchecked
/// and checked-in. In the first state, the user can find restaurants via
/// recommendations displayed on horizontal carousels or a list of nearby
/// restaurants at the bottom. In the checked-in state, the Home screen adapts
/// itself to display options from the selected restaurant's menu.
class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onTopBarButtonPressed() {
    Navigator.of(context).pushNamed(ScannerScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          _buildTopBar(),
          Stack(
            children: <Widget>[
              _Header(mode: _HomeMode.checked, outlet: dummyOutlets[0]),
              _HomeContent()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTopBar() => LUTopBar(
        children: <Widget>[
          Image.asset(
            Images.appLogo,
            width: 227,
            height: 46,
            fit: BoxFit.cover,
          ),
          LUIconButton(
            icon: MaterialCommunityIcons.qrcode_scan,
            iconSize: 32,
            onPressed: _onTopBarButtonPressed,
          )
        ],
      );
}

class _Header extends StatelessWidget {
  final _HomeMode mode;
  final Outlet outlet;

  const _Header({
    Key key,
    @required this.mode,
    this.outlet,
  })  : assert(mode != null),
        assert(mode == _HomeMode.checked && outlet != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _HomeStyles.headerHeight,
      width: double.infinity,
      margin: EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        borderRadius: _HomeStyles.backgroundBorderRadius,
        color: LUColors.yellow,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 12,
            offset: Offset(0, 4), // changes position of shadow
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: _HomeStyles.backgroundBorderRadius,
          child: mode == _HomeMode.checked
              ? buildCheckedHeader(context)
              : buildUncheckedHeader(context)),
    );
  }

  Widget buildCheckedHeader(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
              child: FadeInImage.assetNetwork(
            placeholder: Images.verticalPlaceholder,
            image: outlet.imgSrc,
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: LUBlurFilter(
            blurIntensity: 3.0,
            color: Colors.grey.shade600,
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(outlet.name, style: Styles.homeCheckedHeaderTitle),
              Text(outlet.category, style: Styles.homeCheckedHeaderSubtitle),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LUStarRating(
                    rating: 4,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(outlet.priceRange, style: Styles.cardPriceRange)
                ],
              )
            ],
          )
        ],
      );

  Widget buildUncheckedHeader(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
              child:
                  Image.asset(Images.homeHeaderBackground, fit: BoxFit.fill)),
          Positioned.fill(
            bottom: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Images.homeChef,
                  height: 128,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Time to get\nsome ',
                          style: LUTheme.of(context).textTheme.headline3),
                      TextSpan(
                          text: 'food',
                          style: LUTheme.of(context).textTheme.headline2)
                    ]),
                  ),
                )
              ],
            ),
          ),
        ],
      );
}

class _HomeContent extends StatelessWidget {
  List<Widget> _getCategoryCards(context) => dummyCuisines
      .map((cuisine) => LUCategoryCard(
            title: cuisine.name,
            imageSrc: cuisine.imgSrc,
            onPressed: () {
              Navigator.of(context).pushNamed(CuisineScreen.id,
                  arguments: ScreenArguments(
                      title: cuisine.name, coverImgSrc: cuisine.imgSrc));
            },
          ))
      .toList();

  List<Widget> _getFeaturedCards(context) => dummyFeaturedOutlets
      .map((outlet) => LUFeaturedCard(
            imageSrc: outlet.imgSrc,
            title: outlet.name,
            subtitle: outlet.category,
            onPressed: () {
              Navigator.of(context).pushNamed(OutletScreen.id,
                  arguments: ScreenArguments(
                      title: outlet.name, coverImgSrc: outlet.imgSrc));
            },
            rating: outlet.rating,
            priceRange: outlet.priceRange,
          ))
      .toList();

  List<Widget> _getOutletCards(context) => dummyOutlets
      .map((outlet) => LUOutletCard(
            imageSrc: outlet.imgSrc,
            rating: outlet.rating,
            title: outlet.name,
            priceRange: outlet.priceRange,
            onPressed: () {
              Navigator.of(context).pushNamed(ProductScreen.id,
                  arguments: ScreenArguments(
                      title: outlet.name, coverImgSrc: outlet.imgSrc));
            },
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 192),
        decoration: BoxDecoration(
          color: LUColors.smoothWhite,
          borderRadius: _HomeStyles.backgroundBorderRadius,
        ),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: LUSolidButton(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 32),
                title: "Find a Restaurant",
                onPressed: () {}),
          ),
          LUSection(
              title: "Chef's choice - Glasgow",
              child: LUCarousel(
                  height: _HomeStyles.featuredSectionHeight,
                  padding: Styles.sectionContentPadding,
                  items: _getFeaturedCards(context))),
          LUSection(
              title: 'Cuisines',
              child: LUCarousel(
                  height: Styles.categoryCarouselHeight,
                  padding: Styles.sectionContentPadding,
                  items: _getCategoryCards(context))),
          LUSection(
            title: 'Nearby Restaurants',
            child: LUList(
              nested: true,
              space: 10,
              items: _getOutletCards(context),
            ),
          ),
        ]));
  }
}

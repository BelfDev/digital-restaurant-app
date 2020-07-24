import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/cards/featured_card.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'cuisine_screen.dart';

abstract class _HomeStyles {
  static const topBarPadding =
      const EdgeInsets.only(left: 16, right: 16, top: 8);
  static const double headerHeight = 200;
  static const backgroundBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(40), topRight: Radius.circular(40));
  static const double featuredSectionHeight = 280;
  static const double cuisineSectionHeight = 160;
  static const sectionSpacing = const EdgeInsets.only(top: 16.0);
}

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
        children: <Widget>[
          _buildTopBar(),
          Stack(
            children: <Widget>[_Header(), _HomeContent()],
          )
        ],
      ),
    );
  }

  Widget _buildTopBar() => Padding(
        padding: _HomeStyles.topBarPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'res/images/logo.png',
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
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _HomeStyles.headerHeight,
      width: double.infinity,
      margin: EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        borderRadius: _HomeStyles.backgroundBorderRadius,
        color: LUColors.yellow,
      ),
      child: ClipRRect(
        borderRadius: _HomeStyles.backgroundBorderRadius,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child:
                    Image.asset('res/images/header-bg.png', fit: BoxFit.fill)),
            Positioned.fill(
              bottom: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'res/images/home-chef.png',
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
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  List<Widget> _getCategoryCards(context) => dummyCuisines
      .map((cuisine) => LUCategoryCard(
            title: cuisine.name,
            imageSrc: cuisine.imgSrc,
            onPressed: () {
              Navigator.of(context).pushNamed(CuisineScreen.id,
                  arguments: ScreenArguments(coverImgSrc: cuisine.imgSrc));
            },
          ))
      .toList();

  List<Widget> _getFeaturedCards() => dummyFeaturedOutlets
      .map((outlet) => LUFeaturedCard(
            imageSrc: outlet.imgSrc,
            title: outlet.name,
            subtitle: outlet.category,
            onPressed: () {},
            rating: outlet.rating,
            priceRange: outlet.priceRange,
          ))
      .toList();

  List<Widget> _getOutletCards() => dummyOutlets
      .map((outlet) => LUOutletCard(
            imageSrc: outlet.imgSrc,
            rating: outlet.rating,
            title: outlet.name,
            priceRange: outlet.priceRange,
            onPressed: () {},
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
          _HorizontalHomeSection(
              title: "Chef's choice - Glasgow",
              height: _HomeStyles.featuredSectionHeight,
              items: _getFeaturedCards()),
          _HorizontalHomeSection(
            title: 'Cuisines',
            height: _HomeStyles.cuisineSectionHeight,
            items: _getCategoryCards(context),
          ),
          _VerticalHomeSection(
              title: 'Nearby Restaurants', items: _getOutletCards())
        ]));
  }
}

class _HorizontalHomeSection extends StatelessWidget {
  final double height;
  final String title;
  final List<Widget> items;

  const _HorizontalHomeSection({Key key, this.height, this.title, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _HomeStyles.sectionSpacing,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              title,
              style: Styles.section,
            ),
          ),
          LUCarousel(
              height: height,
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              items: items)
        ],
      ),
    );
  }
}

class _VerticalHomeSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _VerticalHomeSection({Key key, this.title, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _HomeStyles.sectionSpacing,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 12),
              child: Text(
                title,
                style: Styles.section,
              ),
            ),
            LUList(
              nested: true,
              space: 10,
              items: items,
            )
          ]),
    );
  }
}

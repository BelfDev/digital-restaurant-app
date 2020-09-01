import 'dart:ui';

import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/components/blur_filter.dart';
import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/cards/dish_card.dart';
import 'package:dr_app/components/cards/featured_card.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/components/chip_carousel.dart';
import 'package:dr_app/components/decorated_title.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/loadable_content.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/outlet.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/screens/product_screen.dart';
import 'package:dr_app/screens/scanner_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
// class HomeScreen extends StatefulWidget {
//   static const id = 'home_screen';
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   static const _CITY_REGION = 'Glasgow';
//
//   _HomeMode mode;
//   HomeBloc _homeBloc;
//
//   @override
//   void initState() {
//     super.initState();
//     mode = _HomeMode.unchecked;
//     _homeBloc = _homeBloc = BlocProvider.of<HomeBloc>(context)
//       ..add(FeaturedOutletsRequested(city: _CITY_REGION))
//       ..add(CuisinesRequested())
//       ..add(NearbyOutletsRequested(city: _CITY_REGION));
//   }
//
//   void _onTopBarButtonPressed() {
//     Navigator.of(context).pushNamed(ScannerScreen.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: close_sinks
//     return SafeArea(
//       bottom: false,
//       child: ListView(
//         physics: ClampingScrollPhysics(),
//         children: <Widget>[
//           _buildTopBar(),
//           Stack(
//             children: <Widget>[
//               _Header(mode: mode, outlet: dummyOutlets[0]),
//               _HomeContent(
//                 mode: mode,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopBar() => LUTopBar(
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 mode = mode == _HomeMode.checked
//                     ? _HomeMode.unchecked
//                     : _HomeMode.checked;
//               });
//             },
//             child: Image.asset(
//               Images.appLogo,
//               width: 227,
//               height: 46,
//               fit: BoxFit.cover,
//             ),
//           ),
//           LUIconButton(
//             icon: MaterialCommunityIcons.qrcode_scan,
//             iconSize: 32,
//             onPressed: _onTopBarButtonPressed,
//           )
//         ],
//       );
// }
//
// class _Header extends StatelessWidget {
//   final _HomeMode mode;
//   final Outlet outlet;
//
//   const _Header({
//     Key key,
//     @required this.mode,
//     this.outlet,
//   })  : assert(mode != null),
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: _HomeStyles.headerHeight,
//       width: double.infinity,
//       margin: EdgeInsets.only(top: 24),
//       decoration: BoxDecoration(
//         borderRadius: _HomeStyles.backgroundBorderRadius,
//         color: LUColors.yellow,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 4,
//             blurRadius: 12,
//             offset: Offset(0, 4), // changes position of shadow
//           )
//         ],
//       ),
//       child: ClipRRect(
//           borderRadius: _HomeStyles.backgroundBorderRadius,
//           child: mode == _HomeMode.checked
//               ? buildCheckedHeader(context)
//               : buildUncheckedHeader(context)),
//     );
//   }
//
//   Widget buildCheckedHeader(BuildContext context) => Stack(
//         children: <Widget>[
//           Positioned.fill(
//               child: FadeInImage.assetNetwork(
//             placeholder: Images.verticalPlaceholder,
//             image: outlet.imgSrc,
//             fit: BoxFit.cover,
//           )),
//           Positioned.fill(
//               child: LUBlurFilter(
//             blurIntensity: 3.0,
//             color: Colors.grey.shade600,
//           )),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(outlet.name, style: Styles.homeCheckedHeaderTitle),
//               Text(outlet.category, style: Styles.homeCheckedHeaderSubtitle),
//               SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   LUStarRating(
//                     rating: 4,
//                   ),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   Text(outlet.priceRange, style: Styles.cardPriceRange)
//                 ],
//               )
//             ],
//           )
//         ],
//       );
//
//   Widget buildUncheckedHeader(BuildContext context) => Stack(
//         children: <Widget>[
//           Positioned.fill(
//               child:
//                   Image.asset(Images.homeHeaderBackground, fit: BoxFit.fill)),
//           Positioned.fill(
//             bottom: 32,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Image.asset(
//                   Images.homeChef,
//                   height: 128,
//                   width: 120,
//                   fit: BoxFit.cover,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 64),
//                   child: RichText(
//                     text: TextSpan(children: <TextSpan>[
//                       TextSpan(
//                           text: 'Time to get\nsome ',
//                           style: LUTheme.of(context).textTheme.headline3),
//                       TextSpan(
//                           text: 'food',
//                           style: LUTheme.of(context).textTheme.headline2)
//                     ]),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       );
// }
//
// class _HomeContent extends StatelessWidget {
//   final _HomeMode mode;
//   final Outlet outlet;
//
//   const _HomeContent({
//     Key key,
//     @required this.mode,
//     this.outlet,
//   }) : super(key: key);
//
//   Widget buildFeaturedOutletsCarousel(BuildContext context) =>
//       BlocBuilder<HomeBloc, HomeState>(
//         buildWhen: (previous, current) =>
//             previous.featuredOutletsStatus != current.featuredOutletsStatus,
//         builder: (_, state) => LULoadableContent(
//             height: _HomeStyles.featuredSectionHeight,
//             stateStatus: state.featuredOutletsStatus,
//             contentBuilder: () => LUCarousel(
//                 height: _HomeStyles.featuredSectionHeight,
//                 padding: Styles.sectionContentPadding,
//                 items: state.featuredOutlets
//                     .map((outlet) => LUFeaturedCard(
//                           imageSrc: outlet.images.isNotEmpty
//                               ? outlet.images.first.source
//                               : '',
//                           title: outlet.title,
//                           subtitle: outlet.cuisine.title,
//                           priceRange: outlet.priceLevel,
//                           rating: outlet.rating,
//                         ))
//                     .toList())),
//       );
//
//   Widget buildCategoryCarousel(BuildContext context) =>
//       BlocBuilder<HomeBloc, HomeState>(
//           buildWhen: (previous, current) =>
//               previous.cuisineStatus != current.cuisineStatus,
//           builder: (_, state) => LULoadableContent(
//               height: Styles.categoryCarouselHeight,
//               stateStatus: state.cuisineStatus,
//               contentBuilder: () => LUCarousel(
//                   height: Styles.categoryCarouselHeight,
//                   padding: Styles.sectionContentPadding,
//                   items: state.cuisines
//                       .map((cuisine) => LUCategoryCard(
//                             title: cuisine.title,
//                             imageSrc: cuisine.image.source,
//                             onPressed: () {
//                               Navigator.of(context).pushNamed(CuisineScreen.id,
//                                   arguments: ScreenArguments(
//                                       title: cuisine.title,
//                                       coverImgSrc: cuisine.image.source));
//                             },
//                           ))
//                       .toList())));
//
//   // TODO: Add pagination
//   // TODO: Incorporate BlocBuilder inside LoadableContent widget
//   Widget buildNearbyOutletsList(BuildContext context) =>
//       BlocBuilder<HomeBloc, HomeState>(
//           buildWhen: (previous, current) =>
//               previous.nearbyOutletsStatus != current.nearbyOutletsStatus,
//           builder: (_, state) => LULoadableContent(
//               height: 200,
//               stateStatus: state.nearbyOutletsStatus,
//               contentBuilder: () {
//                 return LUList(
//                     nested: true,
//                     space: 10,
//                     items: state.nearbyOutlets
//                         .map((outlet) => LUOutletCard(
//                               imageSrc: outlet.images.isNotEmpty
//                                   ? outlet.images.first.source
//                                   : '',
//                               rating: outlet.rating,
//                               title: outlet.title,
//                               priceRange: outlet.priceLevel,
//                               onPressed: () {
//                                 Navigator.of(context)
//                                     .pushNamed(ProductScreen.id,
//                                         arguments: ScreenArguments(
//                                           title: outlet.title,
//                                           coverImgSrc: outlet.images.isNotEmpty
//                                               ? outlet.images.first.source
//                                               : '',
//                                         ));
//                               },
//                             ))
//                         .toList());
//               }));
//
//   List<Widget> _getFeaturedCards(context) => dummyDishes
//       .map((dish) => LUFeaturedCard(
//             imageSrc: dish.imgSrc,
//             title: dish.title,
//             onPressed: () {
//               Navigator.of(context).pushNamed(ProductScreen.id,
//                   arguments: ScreenArguments(
//                       title: dish.title, coverImgSrc: dish.imgSrc));
//             },
//             price: dish.priceTag,
//           ))
//       .toList();
//
//   List<Widget> _getDishCards() => dummyDishes
//       .map((dish) => LUDishCard(
//             imageSrc: dish.imgSrc,
//             title: dish.title,
//             description: dish.description,
//             priceTag: dish.priceTag,
//             preparationTime: dish.preparationTime,
//           ))
//       .toList();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 192),
//         decoration: BoxDecoration(
//           color: LUColors.smoothWhite,
//           borderRadius: _HomeStyles.backgroundBorderRadius,
//         ),
//         child: mode == _HomeMode.checked
//             ? buildCheckedContent(context)
//             : buildUncheckedContent(context));
//   }
//
//   // TODO: Fix multiple HomeBloc events interference
//   Widget buildUncheckedContent(BuildContext context) =>
//       Column(children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(top: 16, bottom: 16),
//           child: LUSolidButton(
//               width: double.infinity,
//               margin: EdgeInsets.symmetric(horizontal: 32),
//               title: "Find a Restaurant",
//               onPressed: () {}),
//         ),
//         LUSection(
//             title: "Chef's choice - Glasgow",
//             child: buildFeaturedOutletsCarousel(context)),
//         LUSection(title: 'Cuisines', child: buildCategoryCarousel(context)),
//         LUSection(
//             title: 'Nearby Restaurants',
//             child: buildNearbyOutletsList(context)),
//       ]);
//
//   Widget buildCheckedContent(BuildContext context) => Column(children: <Widget>[
//         Padding(
//             padding: const EdgeInsets.only(top: 16, bottom: 16),
//             child: LUDecoratedTitle(
//               title: 'Menu',
//             )),
//         LUSection(
//             title: "Popular",
//             child: LUCarousel(
//                 height: _HomeStyles.featuredSectionHeight,
//                 padding: Styles.sectionContentPadding,
//                 items: _getFeaturedCards(context))),
//         LUSection(
//           title: 'Categories',
//           child: LUChipCarousel(
//             items: dummyChipItems,
//             onSelected: (value) {
//               print(value);
//             },
//           ),
//         ),
//         LUList(
//           padding: EdgeInsets.only(top: 16),
//           nested: true,
//           space: 10,
//           items: _getDishCards(),
//         ),
//       ]);
// }

class LegacyHomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LegacyHomeScreen> {
  static const _CITY_REGION = 'Glasgow';

  _HomeMode mode;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    mode = _HomeMode.unchecked;
    _homeBloc = _homeBloc = BlocProvider.of<HomeBloc>(context)
      ..add(FeaturedOutletsRequested(city: _CITY_REGION))
      ..add(CuisinesRequested())
      ..add(NearbyOutletsRequested(city: _CITY_REGION));
  }

  void _onTopBarButtonPressed() {
    Navigator.of(context).pushNamed(ScannerScreen.id);
  }

  // @override
  // Widget build(BuildContext context) {
  //   // ignore: close_sinks
  //   return SafeArea(
  //     bottom: false,
  //     child: ListView(
  //       physics: ClampingScrollPhysics(),
  //       children: <Widget>[
  //         _buildTopBar(),
  //         Stack(
  //           children: <Widget>[
  //             _Header(mode: mode, outlet: dummyOutlets[0]),
  //             _HomeContent(
  //               mode: mode,
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Available seats'),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {/* ... */},
              ),
            ]),
        _Header(
          mode: mode,
        ),

        // SliverToBoxAdapter(child: _Header(mode: mode, outlet: dummyOutlets[0])),
        SliverToBoxAdapter(
          child: LUSection(
              title: 'Cuisines',
              builder: (_) => buildCategoryCarousel(context)),
        ),

        // SliverList(
        //   delegate:
        //       SliverChildBuilderDelegate((BuildContext context, int index) {
        //     return LUSection(
        //         title: 'Cuisines', child: buildCategoryCarousel(context));
        //   }, childCount: 4),
        // ),
      ],
    );
  }

  Widget buildCategoryCarousel(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.cuisineStatus != current.cuisineStatus,
          builder: (_, state) => LULoadableContent(
              height: Styles.categoryCarouselHeight,
              stateStatus: state.cuisineStatus,
              contentBuilder: () => LUCarousel(
                  height: Styles.categoryCarouselHeight,
                  padding: Styles.sectionContentPadding,
                  items: state.cuisines
                      .map((cuisine) => LUCategoryCard(
                            title: cuisine.title,
                            imageSrc: cuisine.image.source,
                            onPressed: () {
                              Navigator.of(context).pushNamed(CuisineScreen.id,
                                  arguments: ScreenArguments(
                                      title: cuisine.title,
                                      coverImgSrc: cuisine.image.source));
                            },
                          ))
                      .toList())));

  // @override
  // Widget build(BuildContext context) {
  //   // ignore: close_sinks
  //   return SafeArea(
  //     bottom: false,
  //     child: ListView(
  //       physics: ClampingScrollPhysics(),
  //       children: <Widget>[
  //         _buildTopBar(),
  //         Stack(
  //           children: <Widget>[
  //             _Header(mode: mode, outlet: dummyOutlets[0]),
  //             _HomeContent(
  //               mode: mode,
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTopBar() => LUTopBar(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                mode = mode == _HomeMode.checked
                    ? _HomeMode.unchecked
                    : _HomeMode.checked;
              });
            },
            child: Image.asset(
              Images.appLogo,
              width: 227,
              height: 46,
              fit: BoxFit.cover,
            ),
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
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: _HomeStyles.headerHeight,
        width: double.infinity,
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          borderRadius: _HomeStyles.backgroundBorderRadius,
          color: LUColors.yellow,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 12,
              offset: Offset(0, -12), // changes position of shadow
            )
          ],
        ),
        child: ClipRRect(
            borderRadius: _HomeStyles.backgroundBorderRadius,
            child: mode == _HomeMode.checked
                ? buildCheckedHeader(context)
                : buildUncheckedHeader(context)),
      ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                  color: LUTheme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0))),
            ),
          ),
        ],
      );
}

class _HomeContent extends StatelessWidget {
  final _HomeMode mode;
  final Outlet outlet;

  const _HomeContent({
    Key key,
    @required this.mode,
    this.outlet,
  }) : super(key: key);

  Widget buildFeaturedOutletsCarousel(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.featuredOutletsStatus != current.featuredOutletsStatus,
        builder: (_, state) => LULoadableContent(
            height: _HomeStyles.featuredSectionHeight,
            stateStatus: state.featuredOutletsStatus,
            contentBuilder: () => LUCarousel(
                height: _HomeStyles.featuredSectionHeight,
                padding: Styles.sectionContentPadding,
                items: state.featuredOutlets
                    .map((outlet) => LUFeaturedCard(
                          imageSrc: outlet.images.isNotEmpty
                              ? outlet.images.first.source
                              : '',
                          title: outlet.title,
                          subtitle: outlet.cuisine.title,
                          priceRange: outlet.priceLevel,
                          rating: outlet.rating,
                        ))
                    .toList())),
      );

  Widget buildCategoryCarousel(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.cuisineStatus != current.cuisineStatus,
          builder: (_, state) => LULoadableContent(
              height: Styles.categoryCarouselHeight,
              stateStatus: state.cuisineStatus,
              contentBuilder: () => LUCarousel(
                  height: Styles.categoryCarouselHeight,
                  padding: Styles.sectionContentPadding,
                  items: state.cuisines
                      .map((cuisine) => LUCategoryCard(
                            title: cuisine.title,
                            imageSrc: cuisine.image.source,
                            onPressed: () {
                              Navigator.of(context).pushNamed(CuisineScreen.id,
                                  arguments: ScreenArguments(
                                      title: cuisine.title,
                                      coverImgSrc: cuisine.image.source));
                            },
                          ))
                      .toList())));

  // TODO: Add pagination
  // TODO: Incorporate BlocBuilder inside LoadableContent widget
  Widget buildNearbyOutletsList(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.nearbyOutletsStatus != current.nearbyOutletsStatus,
          builder: (_, state) => LULoadableContent(
              height: 200,
              stateStatus: state.nearbyOutletsStatus,
              contentBuilder: () {
                return LUList(
                    nested: true,
                    space: 10,
                    items: state.nearbyOutlets
                        .map((outlet) => LUOutletCard(
                              imageSrc: outlet.images.isNotEmpty
                                  ? outlet.images.first.source
                                  : '',
                              rating: outlet.rating,
                              title: outlet.title,
                              priceRange: outlet.priceLevel,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ProductScreen.id,
                                        arguments: ScreenArguments(
                                          title: outlet.title,
                                          coverImgSrc: outlet.images.isNotEmpty
                                              ? outlet.images.first.source
                                              : '',
                                        ));
                              },
                            ))
                        .toList());
              }));

  List<Widget> _getFeaturedCards(context) => dummyDishes
      .map((dish) => LUFeaturedCard(
            imageSrc: dish.imgSrc,
            title: dish.title,
            onPressed: () {
              Navigator.of(context).pushNamed(ProductScreen.id,
                  arguments: ScreenArguments(
                      title: dish.title, coverImgSrc: dish.imgSrc));
            },
            price: dish.priceTag,
          ))
      .toList();

  List<Widget> _getDishCards() => dummyDishes
      .map((dish) => LUDishCard(
            imageSrc: dish.imgSrc,
            title: dish.title,
            description: dish.description,
            priceTag: dish.priceTag,
            preparationTime: dish.preparationTime,
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
        child: mode == _HomeMode.checked
            ? buildCheckedContent(context)
            : buildUncheckedContent(context));
  }

  // TODO: Fix multiple HomeBloc events interference
  Widget buildUncheckedContent(BuildContext context) =>
      Column(children: <Widget>[
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
            builder: (_) => buildFeaturedOutletsCarousel(context)),
        LUSection(
            title: 'Cuisines', builder: (_) => buildCategoryCarousel(context)),
        LUSection(
            title: 'Nearby Restaurants',
            builder: (_) => buildNearbyOutletsList(context)),
      ]);

  Widget buildCheckedContent(BuildContext context) => Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: LUDecoratedTitle(
              title: 'Menu',
            )),
        LUSection(
            title: "Popular",
            builder: (_) => LUCarousel(
                height: _HomeStyles.featuredSectionHeight,
                padding: Styles.sectionContentPadding,
                items: _getFeaturedCards(context))),
        LUSection(
          title: 'Categories',
          builder: (_) => LUChipCarousel(
            items: dummyChipItems,
            onSelected: (value) {
              print(value);
            },
          ),
        ),
        LUList(
          padding: EdgeInsets.only(top: 16),
          nested: true,
          space: 10,
          items: _getDishCards(),
        ),
      ]);
}

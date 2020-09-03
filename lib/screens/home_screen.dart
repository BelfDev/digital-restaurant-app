import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/components/components.dart';
import 'package:dr_app/components/sliver_app_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/models.dart' hide Image;
import 'package:dr_app/screens/screens.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/formatter.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

abstract class _HomeStyles {
  static const double headerHeight = 250;
  static const backgroundBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(40), topRight: Radius.circular(40));
  static const double featuredSectionHeight = 280;
}

typedef _SectionList = List<Widget> Function(BuildContext context);

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
  static const _CITY_REGION = 'Glasgow';

  HomeBloc _homeBloc;

  void _onScannerButtonPressed(BuildContext context) async {
    _homeBloc.add(CheckOutRequested());
    // final result = await Navigator.of(context).pushNamed(ScannerScreen.id);
    // if (result != null) {
    //
    // }
    // _showDialog('Uh-oh', 'QR-Code not valid');

    // setState(() {
    //   mode =
    //       mode == _HomeMode.checked ? _HomeMode.unchecked : _HomeMode.checked;
    // });
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context)
      ..add(FeaturedOutletsRequested(city: _CITY_REGION))
      ..add(CuisinesRequested())
      ..add(NearbyOutletsRequested(city: _CITY_REGION));
  }

  @override
  Widget build(BuildContext context) {
    return LUScrollScaffold(
      appBar: _buildAppBar,
      header: _buildHeader,
      body: _buildBody,
    );
  }

  Widget _buildAppBar(BuildContext context) => LUSliverAppBar(
        children: [
          GestureDetector(
            onTap: () {},
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
            onPressed: () => _onScannerButtonPressed(context),
          )
        ],
      );

  Widget _buildHeader(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.mode != current.mode,
        builder: (context, state) => _Header(
            mode: state.mode,
            onButtonPressed: () {
              _homeBloc.add(CheckInRequested(1));
            },
            outlet: state.homeOutlet),
      );

  Widget _buildBody(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.mode != current.mode,
        builder: (context, state) => _Body(
          mode: state.mode,
          outlet: state.homeOutlet,
        ),
      );
}

class _Header extends StatelessWidget {
  static const String _buttonTitle = 'find a restaurant';

  const _Header({
    Key key,
    @required this.mode,
    this.outlet,
    this.onButtonPressed,
  })  : assert(mode != null),
        super(key: key);

  final HomeMode mode;
  final Outlet outlet;
  final VoidCallback onButtonPressed;

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
            child: mode == HomeMode.checkedIn
                ? buildCheckedInHeader(context)
                : buildCheckedOutHeader(context)),
      ),
    );
  }

  Widget buildCheckedInHeader(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
              child: FadeInImage.assetNetwork(
            placeholder: Images.verticalPlaceholder,
            // image: outlet?.images?.first?.source ?? '',
            image: '',
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: LUBlurFilter(
            blurIntensity: 3.0,
            color: Colors.grey.shade600,
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Text(outlet.title, style: Styles.homeCheckedHeaderTitle),
              Text(outlet.cuisine.title,
                  style: Styles.homeCheckedHeaderSubtitle),
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
                  Text(Formatter.convertToDollarSign(outlet.priceLevel),
                      style: Styles.cardPriceRange)
                ],
              )
            ],
          ),
          buildHeaderBottomDivider(context)
        ],
      );

  Widget buildCheckedOutHeader(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
              child:
                  Image.asset(Images.homeHeaderBackground, fit: BoxFit.fill)),
          Positioned.fill(
            bottom: 88,
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
          buildHeaderBottomDivider(context)
        ],
      );

  Widget buildHeaderBottomDivider(BuildContext context) {
    final child = mode == HomeMode.checkedIn
        ? LUDecoratedTitle(
            title: 'Menu',
          )
        : LUSolidButton(
            title: _buttonTitle,
            width: double.infinity,
            margin:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            onPressed: onButtonPressed,
          );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: 88,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0))),
          child: child),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key key,
    @required this.mode,
    this.outlet,
  })  : assert(mode != null),
        super(key: key);

  final HomeMode mode;
  final Outlet outlet;

  _SectionList get checkedOutSections => (BuildContext context) => [
        LUSection(
          title: "Chef's choice - Glasgow",
          builder: buildFeaturedOutletsCarousel,
        ),
        LUSection(
          title: 'Cuisines',
          builder: buildCategoryCarousel,
        ),
        LUSection(
          title: 'Nearby Restaurants',
          builder: buildNearbyOutletsList,
        ),
      ];

  _SectionList get checkedInSections => (BuildContext context) => [
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
          padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
          nested: true,
          space: 10,
          items: _getDishCards(),
        ),
      ];

  void onOutletCardPressed(BuildContext context, Outlet outlet) {
    Navigator.of(context).pushNamed(
      ProductScreen.id,
      arguments: ScreenArguments(
        title: outlet.title ?? '',
        coverImgSrc: outlet.images.isNotEmpty ? outlet.images.first.source : '',
      ),
    );
  }

  void onCategoryCardPressed(BuildContext context, Cuisine cuisine) {
    Navigator.of(context).pushNamed(
      CuisineScreen.id,
      arguments: ScreenArguments(
          title: cuisine.title ?? '', coverImgSrc: cuisine.image.source),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sections = mode == HomeMode.checkedIn
        ? checkedInSections(context)
        : checkedOutSections(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => sections[index],
          childCount: sections.length),
    );
  }

  List<Widget> _getFeaturedCards(context) => dummyDishes
      .map((dish) => LUFeaturedCard(
            imageSrc: dish.imgSrc,
            title: dish.title,
            priceRange: 4,
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
                .map(
                  (outlet) => LUFeaturedCard(
                    imageSrc: outlet.images.isNotEmpty
                        ? outlet.images.first.source
                        : '',
                    title: outlet.title,
                    subtitle: outlet.cuisine.title,
                    priceRange: outlet.priceLevel,
                    rating: outlet.rating,
                    onPressed: () => onOutletCardPressed(context, outlet),
                  ),
                )
                .toList(),
          ),
        ),
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
                .map(
                  (cuisine) => LUCategoryCard(
                    title: cuisine.title,
                    imageSrc: cuisine.image.source,
                    onPressed: () => onCategoryCardPressed(context, cuisine),
                  ),
                )
                .toList(),
          ),
        ),
      );

  Widget buildNearbyOutletsList(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.nearbyOutletsStatus != current.nearbyOutletsStatus,
        builder: (_, state) => LULoadableContent(
          height: 200,
          stateStatus: state.nearbyOutletsStatus,
          contentBuilder: () => LUList(
            nested: true,
            space: 10,
            padding: const EdgeInsets.only(bottom: 120.0),
            items: state.nearbyOutlets
                .map((outlet) => LUOutletCard(
                    imageSrc: outlet.images.isNotEmpty
                        ? outlet.images.first.source
                        : '',
                    rating: outlet.rating,
                    title: outlet.title,
                    priceRange: outlet.priceLevel,
                    onPressed: () => onOutletCardPressed(context, outlet)))
                .toList(),
          ),
        ),
      );
}

import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/components/components.dart';
import 'package:dr_app/components/sliver_app_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/models.dart' hide Image;
import 'package:dr_app/screens/outlet_screen.dart';
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
    // Uncomment the line below to force checkout
    // requestCheckOut();
    final result = await Navigator.of(context).pushNamed(ScannerScreen.id);
    requestCheckIn(result);
  }

  void onOutletCardPressed(BuildContext context, Outlet outlet) async {
    final result = await Navigator.of(context).pushNamed(
      OutletScreen.id,
      arguments: outlet,
    );
    requestCheckIn(result);
  }

  void onCategoryCardPressed(BuildContext context, Cuisine cuisine) async {
    final result = await Navigator.of(context)
        .pushNamed(CuisineScreen.id, arguments: cuisine);
    requestCheckIn(result);
  }

  void onProductCardPressed(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(ProductScreen.id, arguments: product);
  }

  void requestCheckIn(dynamic result) {
    if (result != null) {
      final outletId = result as int;
      _homeBloc
        ..add(CheckInRequested(outletId))
        ..add(OutletFeaturedProductsRequested(outletId))
        ..add(OutletProductsRequested(outletId));
    }
  }

  void requestCheckOut() {
    _homeBloc
      ..add(CheckOutRequested())
      ..add(FeaturedOutletsRequested(city: _CITY_REGION))
      ..add(CuisinesRequested())
      ..add(NearbyOutletsRequested(city: _CITY_REGION));
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    requestCheckOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: LUScrollScaffold(
        appBar: _buildAppBar,
        header: _buildHeader,
        body: _buildBody,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) => LUSliverAppBar(
        children: [
          Image.asset(
            Images.appLogo,
            width: 227,
            height: 46,
            fit: BoxFit.cover,
          ),
          LUIconButton(
            icon: MaterialCommunityIcons.qrcode_scan,
            iconSize: 32,
            onPressed: () => _onScannerButtonPressed(context),
          )
        ],
      );

  Widget _buildHeader(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            (previous.homeOutletStatus != current.homeOutletStatus) ||
            (previous.mode != current.mode),
        builder: (context, state) => _Header(
          mode: state.mode,
          stateStatus: state.homeOutletStatus,
          onButtonPressed: () {
            // Demo find a restaurant
            requestCheckIn(1);
          },
          outlet: state.homeOutlet,
        ),
      );

  Widget _buildBody(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.mode != current.mode,
        builder: (context, state) => _Body(
          mode: state.mode,
          outlet: state.homeOutlet,
          onOutletCardPressed: onOutletCardPressed,
          onProductCardPressed: onProductCardPressed,
          onCategoryCardPressed: onCategoryCardPressed,
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
    this.stateStatus,
  })  : assert(mode != null),
        super(key: key);

  final HomeMode mode;
  final Outlet outlet;
  final VoidCallback onButtonPressed;
  final ContentStateStatus stateStatus;

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
              spreadRadius: 2,
              blurRadius: 12,
              offset: Offset(0, -16), // changes position of shadow
            )
          ],
        ),
        child: ClipRRect(
            borderRadius: _HomeStyles.backgroundBorderRadius,
            child: mode == HomeMode.checkedIn
                ? buildCheckedInHeader(context, stateStatus)
                : buildCheckedOutHeader(context)),
      ),
    );
  }

  Widget buildCheckedInHeader(BuildContext context, ContentStateStatus status) {
    final isLoading = status == ContentStateStatus.initial ||
        status == ContentStateStatus.loadInProgress;
    final hasError = status == ContentStateStatus.loadFailure;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FadeInImage.assetNetwork(
            placeholder: Images.verticalPlaceholder,
            image: outlet?.images?.first?.source ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: LUBlurFilter(
            blurIntensity: 3.0,
            color: Colors.grey.shade600,
          ),
        ),
        if (isLoading)
          Positioned.fill(
            bottom: 64,
            child: LULoadingPlaceholder(),
          ),
        if (hasError) LUErrorPlaceholder(),
        if (!isLoading)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  outlet.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.homeCheckedHeaderTitle,
                ),
              ),
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
  }

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

typedef _OutletCardCallback = Function(BuildContext context, Outlet outlet);
typedef _ProductCardCallback = Function(BuildContext context, Product product);
typedef _CategoryCardCallback = Function(BuildContext context, Cuisine cuisine);

class _Body extends StatefulWidget {
  const _Body(
      {Key key,
      @required this.mode,
      this.outlet,
      this.onOutletCardPressed,
      this.onProductCardPressed,
      this.onCategoryCardPressed})
      : assert(mode != null),
        super(key: key);

  final HomeMode mode;
  final Outlet outlet;
  final _OutletCardCallback onOutletCardPressed;
  final _ProductCardCallback onProductCardPressed;
  final _CategoryCardCallback onCategoryCardPressed;

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  int selectedCategoryIndex = 0;

  _SectionList get checkedOutSections => (BuildContext context) => [
        LUSection(
          title: "Chef's choice - Glasgow",
          builder: buildFeaturedOutletsCarousel,
        ),
        LUSection(
          title: 'Cuisines',
          builder: buildCuisineCarousel,
        ),
        LUSection(
          title: 'Nearby Restaurants',
          builder: buildNearbyOutletsList,
        ),
      ];

  _SectionList get checkedInSections => (BuildContext context) => [
        LUSection(
          title: "Popular",
          builder: buildFeaturedProductsCarousel,
        ),
        buildCategories(context),
      ];

  Widget buildCategories(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.productsStatus != current.productsStatus,
        builder: (_, state) => LULoadableContent(
            height: _HomeStyles.featuredSectionHeight,
            stateStatus: state.productsStatus,
            contentBuilder: () {
              // Retrieves categories and products
              final categories = state.categories.keys.toSet().toList();
              final selectedCategory = categories[selectedCategoryIndex];
              final List<Product> products = state.categories[selectedCategory];

              return Column(
                children: [
                  LUSection(
                    title: 'Categories',
                    builder: (_) => LUChipCarousel(
                      items: List.generate(
                          categories.length,
                          (index) => ChipItem(
                              text: categories[index].title, value: index)),
                      onSelected: (index) {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                    ),
                  ),
                  LUList(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                      nested: true,
                      space: 10,
                      items: products
                          .map((product) => LUProductCard(
                                onPressed: () => widget.onProductCardPressed(
                                    context, product),
                                imageSrc: product.images.isEmpty
                                    ? ''
                                    : product.images.first.source,
                                title: product.title,
                                description: product.description,
                                priceTag:
                                    Formatter.convertToMoney(product.unitPrice),
                                preparationTime: product.preparationTime,
                              ))
                          .toList()),
                ],
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    final sections = widget.mode == HomeMode.checkedIn
        ? checkedInSections(context)
        : checkedOutSections(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => sections[index],
          childCount: sections.length),
    );
  }

  Widget buildFeaturedProductsCarousel(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.featuredProductsStatus != current.featuredProductsStatus,
        builder: (_, state) => LULoadableContent(
          height: _HomeStyles.featuredSectionHeight,
          stateStatus: state.featuredProductsStatus,
          contentBuilder: () => LUCarousel(
            height: _HomeStyles.featuredSectionHeight,
            padding: Styles.sectionContentPadding,
            items: state.featuredProducts
                .map(
                  (product) => LUFeaturedCard(
                    imageSrc: product.images.isNotEmpty
                        ? product.images.first.source
                        : '',
                    title: product.title,
                    price: Formatter.convertToMoney(product.unitPrice),
                    onPressed: () =>
                        widget.onProductCardPressed(context, product),
                  ),
                )
                .toList(),
          ),
        ),
      );

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
                    onPressed: () =>
                        widget.onOutletCardPressed(context, outlet),
                  ),
                )
                .toList(),
          ),
        ),
      );

  Widget buildCuisineCarousel(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.cuisineStatus != current.cuisineStatus,
        builder: (_, state) => LULoadableContent(
          height: Styles.cuisineCarouselHeight,
          stateStatus: state.cuisineStatus,
          contentBuilder: () => LUCarousel(
            height: Styles.cuisineCarouselHeight,
            padding: Styles.sectionContentPadding,
            items: state.cuisines
                .map(
                  (cuisine) => LUCategoryCard(
                    title: cuisine.title,
                    imageSrc: cuisine.image.source,
                    onPressed: () =>
                        widget.onCategoryCardPressed(context, cuisine),
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
                .map(
                  (outlet) => LUOutletCard(
                    imageSrc: outlet.images.isNotEmpty
                        ? outlet.images.first.source
                        : '',
                    rating: outlet.rating,
                    title: outlet.title,
                    priceRange: outlet.priceLevel,
                    onPressed: () =>
                        widget.onOutletCardPressed(context, outlet),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

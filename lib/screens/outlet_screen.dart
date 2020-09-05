import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/components/buttons/slider_button.dart';
import 'package:dr_app/components/components.dart';
import 'package:dr_app/components/star_rating.dart';
import 'package:dr_app/components/swiper.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/formatter.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutletScreen extends StatefulWidget {
  static const id = 'outlet_screen';

  final Outlet outlet;

  const OutletScreen(this.outlet, {Key key}) : super(key: key);

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  static const double _listPlaceholderHeight = 250;

  void _onBackButtonPressed() => Navigator.of(context).pop();

  OutletBloc get outletBloc => BlocProvider.of<OutletBloc>(this.context);

  Outlet get outlet => widget.outlet;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    outletBloc..add(OutletProductsRequested(outletId: outlet.id));
  }

  // TODO: Migrate to CustomScrollView/LUScrollScaffold
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildHeader(outlet),
              buildContent(outlet),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LUSliderButton(
              margin: Styles.fixedButtonMargin,
              title: 'Check-in',
              onSlided: () {
                print('ON SLIDED');
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildHeader(Outlet outlet) => Container(
        height: Styles.paginatedHeaderHeight,
        child: Stack(
          children: <Widget>[
            LUSwiper(
                imgSrcList: outlet.images.map((i) => i.source).toList() ?? []),
            LUTopBar(
              onNavigationButtonPressed: _onBackButtonPressed,
            ),
          ],
        ),
      );

  Widget buildContent(Outlet outlet) {
    return BlocBuilder<OutletBloc, OutletState>(
      builder: (BuildContext context, OutletState state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  Styles.sectionContentPadding.copyWith(top: 24, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    outlet.title,
                    style: LUTheme.of(context).textTheme.headline1,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(outlet.cuisine.title, style: Styles.outletSubtitle),
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
                        Formatter.convertToDollarSign(outlet.priceLevel),
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
            buildCategories(context)
          ],
        );
      },
    );
  }

  Widget buildCategories(BuildContext context) =>
      BlocBuilder<OutletBloc, OutletState>(
        builder: (_, state) => LULoadableContent(
            height: _listPlaceholderHeight,
            stateStatus: state.status,
            contentBuilder: () {
              // Retrieves categories and products
              final categories = state.categories.toList();
              final selectedCategory = categories[selectedCategoryIndex];
              final List<Product> products =
                  state.categoryMap[selectedCategory];

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
                      padding: const EdgeInsets.only(top: 16.0, bottom: 132.0),
                      nested: true,
                      space: 10,
                      items: products
                          .map((dish) => LUProductCard(
                                imageSrc: dish.images.isEmpty
                                    ? ''
                                    : dish.images.first.source,
                                title: dish.title,
                                description: dish.description,
                                priceTag:
                                    Formatter.convertToMoney(dish.unitPrice),
                                preparationTime: dish.preparationTime,
                              ))
                          .toList()),
                ],
              );
            }),
      );
}

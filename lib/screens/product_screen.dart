import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/components/counter.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const id = 'product_screen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  List<Widget> _getCategoryCards(context) => dummyCuisines
      .map((cuisine) => LUCategoryCard(
            title: cuisine.name,
            imageSrc: cuisine.imgSrc,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildHeader(args),
            _buildContent(args),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: LUSolidButton(
            title: 'ADD TO BASKET',
            margin: EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _buildHeader(ScreenArguments args) => Container(
        height: 400,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FadeInImage.assetNetwork(
                placeholder: Images.horizontalPlaceholder,
                image: args.coverImgSrc,
                fit: BoxFit.cover,
              ),
            ),
            LUTopBar(
              onNavigationButtonPressed: _onBackButtonPressed,
            ),
          ],
        ),
      );

  Widget _buildContent(ScreenArguments args) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: Styles.sectionContentPadding.copyWith(top: 24, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Chicken Noodles',
                  style: LUTheme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
                Text('£ 8.50 each', style: Styles.productSubtitle),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    LUCounter(
                      onUpdate: (amount) {
                        print(amount);
                      },
                    ),
                    Text(
                      '£ 8.50',
                      style: LUTheme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          LUSection(
            title: 'Dish Description',
            child: Padding(
              padding: Styles.sectionContentPadding,
              child: Text(
                'ASIAN GREENS WITH FRIED TOFU IN A CHILLI, GARLIC, SOY & BASIL SAUCE, SERVED WITH EGG NOODLES CASHEW NUTS & FRESH CHILLI.',
                style: Styles.descriptionText,
              ),
            ),
          ),
          LUSection(
              title: 'Ingredients',
              child: LUCarousel(
                  height: Styles.categoryCarouselHeight,
                  padding: Styles.sectionContentPadding,
                  items: _getCategoryCards(context))),
        ],
      );
}

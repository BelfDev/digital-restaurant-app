import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
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
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _buildHeader(args),
        _buildContent(args),
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
        children: <Widget>[
          Text('Chicken Noodles'),
          Text('£ 8.50 each'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Counter'),
              Text('£ 8.50'),
            ],
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

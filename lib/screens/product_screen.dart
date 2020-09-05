import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/components/counter.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/swiper.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/utils/formatter.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// The Product Screen displays information about a given product.
/// The user can choose the desired quantity and add the product
/// to the cart.
class ProductScreen extends StatefulWidget {
  static const id = 'product_screen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  int priceMultiplier = 1;

  // TODO: Migrate to LUScrollScaffold
  @override
  Widget build(BuildContext context) {
    final ProductScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    final product = args.product;

    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildHeader(product),
              _buildContent(product),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LUSolidButton(
              title: 'ADD TO BASKET',
              margin: Styles.fixedButtonMargin,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(Product product) {
    final images = product?.images?.map((i) => i.source)?.toList() ?? [];

    return Container(
      height: Styles.paginatedHeaderHeight,
      child: Stack(
        children: <Widget>[
          LUSwiper(imgSrcList: images),
          LUTopBar(
            onNavigationButtonPressed: _onBackButtonPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(Product product) {
    final title = product.title;
    final subtitle = '${Formatter.convertToMoney(product.unitPrice)} each';
    final totalPrice =
        Formatter.convertToMoney(product.unitPrice * priceMultiplier);
    final description = product.description;
    final ingredients = product.ingredients;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: Styles.sectionContentPadding.copyWith(top: 24, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: LUTheme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 2,
              ),
              Text(subtitle, style: Styles.productSubtitle),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LUCounter(
                    onUpdate: (amount) {
                      setState(() {
                        priceMultiplier = amount;
                      });
                    },
                  ),
                  Text(
                    totalPrice,
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
          builder: (_) => Padding(
            padding: Styles.sectionContentPadding,
            child: Text(
              description,
              style: Styles.descriptionText,
            ),
          ),
        ),
        LUSection(
          title: 'Ingredients',
          builder: (_) => LUCarousel(
            height: Styles.categoryCarouselHeight,
            padding: Styles.sectionContentPadding,
            items: ingredients
                .map((ingredient) => LUCategoryCard(
                      title: ingredient.title,
                      imageSrc: ingredient.image.source ?? '',
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class ProductScreenArguments {
  final Product product;

  const ProductScreenArguments({
    @required this.product,
  }) : assert(product != null);
}

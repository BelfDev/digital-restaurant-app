import 'package:dr_app/components/cards/dish_card.dart';
import 'package:dr_app/components/compact_header.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const id = 'cart_screen';

  final String coverImgSrc;

  const CartScreen({Key key, @required this.coverImgSrc}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  List<Widget> getDishCards() => dummyDishes
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
    return ListView(
      padding: EdgeInsets.zero,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Stack(
          children: <Widget>[
            LUCompactHeader(
                imgSrc: widget.coverImgSrc,
                icon: Icons.close,
                onTopButtonPressed: onBackButtonPressed),
            buildCartContent()
          ],
        )
      ],
    );
  }

  Widget buildCartContent() {
    return RoundContainer(
      child: Column(
        children: <Widget>[
          LUList(
            padding: EdgeInsets.only(top: 24),
            nested: true,
            space: 10,
            items: getDishCards(),
          ),
        ],
      ),
    );
  }
}

import 'package:dr_app/components/bottom_sliver.dart';
import 'package:dr_app/components/cards/dish_card.dart';
import 'package:dr_app/components/compact_header.dart';
import 'package:dr_app/components/counter.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const id = 'cart_screen';

  final String coverImgSrc;

  const CartScreen({Key key, @required this.coverImgSrc}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<int, Widget> segmentTabs = const <int, Widget>{
    0: Text(
      "Active Tab",
      style: Styles.segmentControlText,
    ),
    1: Text(
      "Order Summary",
      style: Styles.segmentControlText,
    )
  };

  int segmentedControlGroupValue = 0;

  void onBackButtonPressed() {
    Navigator.of(context).pop();
  }

//  List<Widget> getDishCards() => dummyDishes
//      .map((dish) =>
//      LUDishCard(
//            imageSrc: dish.imgSrc,
//            title: dish.title,
//            description: dish.description,
//            priceTag: dish.priceTag,
//            preparationTime: dish.preparationTime,
//          )
//  )
//      .toList();

  List<Widget> getDishCards() => dummyDishes
      .map((dish) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: LUDishCard(
                    margin: EdgeInsets.only(right: 8.0),
                    imageSrc: dish.imgSrc,
                    title: dish.title,
                    description: dish.description,
                    priceTag: dish.priceTag,
                    preparationTime: dish.preparationTime,
                  ),
                ),
                LUCounter(vertical: true, onUpdate: () {}),
              ],
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  LUCompactHeader(
                      imgSrc: widget.coverImgSrc,
                      icon: Icons.close,
                      onTopButtonPressed: onBackButtonPressed),
                  buildCartContent(),
                ],
              )
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: LUBottomSliver(
                buttonTitle: 'order',
                subtotal: 30,
                buttonType: BottomSliverButton.SOLID,
                onButtonPressed: () {
                  print('Cart button pressed');
                },
              ))
        ],
      ),
    );
  }

  Widget buildCartContent() {
    return RoundContainer(
      child: Column(
        children: <Widget>[
          CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlGroupValue,
              children: segmentTabs,
              onValueChanged: (i) {
                setState(() {
                  segmentedControlGroupValue = i;
                });
              }),
          LUList(
            padding: EdgeInsets.only(top: 24, bottom: 56),
            nested: true,
            space: 10,
            items: getDishCards(),
          ),
        ],
      ),
    );
  }
}

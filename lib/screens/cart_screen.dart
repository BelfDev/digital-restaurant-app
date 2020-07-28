import 'package:dr_app/components/bottom_sheet_container.dart';
import 'package:dr_app/components/bottom_sliver.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/dish_card.dart';
import 'package:dr_app/components/compact_header.dart';
import 'package:dr_app/components/counter.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/screens/payment_screen.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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

  List<Widget> getDishCards() => dummyDishes
      .map((dish) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: LUDishCard(
                    margin: (segmentedControlGroupValue == 0)
                        ? EdgeInsets.only(right: 8.0)
                        : EdgeInsets.zero,
                    shrink: segmentedControlGroupValue == 0,
                    showStatus: segmentedControlGroupValue != 0,
                    imageSrc: dish.imgSrc,
                    title: dish.title,
                    description: dish.description,
                    priceTag: dish.priceTag,
                    preparationTime: dish.preparationTime,
                    quantity: 10,
                  ),
                ),
                buildCounter()
              ],
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
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
                buttonTitle:
                    segmentedControlGroupValue == 0 ? 'order' : 'check-out',
                subtotal: 30,
                buttonType: segmentedControlGroupValue == 0
                    ? BottomSliverButton.SOLID
                    : BottomSliverButton.SLIDER,
                onButtonPressed: () {
                  if (segmentedControlGroupValue == 0) {
                    setState(() {
                      segmentedControlGroupValue = 1;
                    });
                  } else {
                    activateBottomSheet(context);
                  }
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

  Widget buildCounter() {
    if (segmentedControlGroupValue == 0) {
      return LUCounter(
          vertical: true,
          onUpdate: (quantity) {
            print(quantity);
          });
    } else {
      return Container();
    }
  }

  void activateBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(LUTheme.bottomSheetRadius),
                topLeft: Radius.circular(LUTheme.bottomSheetRadius))),
        builder: (ctx) {
          return LUBottomSheetContainer(
            title: 'Choose payment method',
            children: <Widget>[
              LUSolidButton(
                title: 'Pay with Pay',
                uppercase: false,
                color: Colors.black,
                onPressed: () {},
              ),
              LUSolidButton(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                title: 'Pay with credit card',
                uppercase: false,
                color: LUTheme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
              ),
            ],
          );
        });
  }
}

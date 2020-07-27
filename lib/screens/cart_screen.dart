import 'package:dr_app/components/compact_header.dart';
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
                onTopButtonPressed: onBackButtonPressed),
          ],
        )
      ],
    );
  }
}

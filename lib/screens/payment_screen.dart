import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static const id = 'payment_screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          LUTopBar(
            title: 'Payment',
            buttonBackgroundColor: LUTheme.of(context).primaryColor,
            tint: LUTheme.of(context).backgroundColor,
          ),
          Container(
            color: Colors.red,
            height: 400,
          )
        ],
      ),
    );
  }
}

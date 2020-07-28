import 'package:dr_app/components/bottom_sliver.dart';
import 'package:dr_app/components/tip_toolbar.dart';
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
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              LUTopBar(
                title: 'Payment',
                buttonBackgroundColor: LUTheme.of(context).primaryColor,
                tint: LUTheme.of(context).backgroundColor,
                onNavigationButtonPressed: () => Navigator.of(context).pop(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LUTipToolbar(
                  margin: EdgeInsets.only(top: 8.0),
                  tipOptions: ['😢', '10%', '15%', '20%'],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LUBottomSliver(
              buttonTitle: 'pay',
              onButtonPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:dr_app/components/bottom_sliver.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/tip_toolbar.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/tip.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static const id = 'payment_screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double tipIncluded;

  @override
  void initState() {
    super.initState();
    tipIncluded = 0.0;
  }

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
              LUSection(
                title: 'Tip the service',
                margin: EdgeInsets.only(top: 32.0),
                child: LUTipToolbar(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  tipOptions: [
                    Tip('😢', 0.0),
                    Tip('10%', 0.10),
                    Tip('15%', 0.15),
                    Tip('20%', 0.20),
                  ],
                  onPressed: (tip) {
                    print(tip.displayText);
                    setState(() {
                      tipIncluded = tip.value;
                    });
                  },
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LUBottomSliver(
              buttonTitle: 'pay',
              tip: tipIncluded,
              onButtonPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The AddCreditCardScreen provides the user with input fields
/// to register a new credit card as a payment option.
class AddCreditCardScreen extends StatefulWidget {
  static const id = 'add_credit_card_screen';

  @override
  _AddCreditCardScreenState createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  final addCreditCardContent = <Widget>[
    CreditCard(
      cardBackground: GradientCardBackground(LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.blue, Colors.purple],
        stops: [0.3, 0.95],
      )),
      cardNetworkType: CardNetworkType.mastercard,
      cardHolderName: 'Very Very very boring devloper',
      cardNumber: '4567',
      company: CardCompany.hsbc,
      validity: Validity(
        validThruMonth: 2,
        validThruYear: 2021,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = LUTheme.of(context);

    return SafeArea(
        child: Container(
      color: theme.backgroundColor,
      child: Column(
        children: <Widget>[
          LUTopBar(
            title: 'Add new card',
            buttonBackgroundColor: theme.primaryColor,
            tint: theme.backgroundColor,
            onNavigationButtonPressed: () => Navigator.of(context).pop(),
            trailingButton: LUIconButton(
              backgroundColor: theme.primaryColor,
              tint: theme.backgroundColor,
              icon: Icons.crop_free,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ...addCreditCardContent
        ],
      ),
    ));
  }
}

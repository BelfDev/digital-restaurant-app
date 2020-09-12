import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/input_field.dart';
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

// TODO: Wire up state
class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = LUTheme.of(context);

    return Container(
      color: theme.backgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
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
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CreditCard(
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
            ),
            buildForm(context),
            LUSolidButton(
              margin: EdgeInsets.all(16.0),
              title: 'Save',
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            LUInputField(
              fieldTitle: 'Card Number',
              hintText: '1111 2222 3333',
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child:
                        LUInputField(fieldTitle: 'Expiry', hintText: '07/22')),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: LUInputField(fieldTitle: 'CVV', hintText: '007')),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: LUInputField(fieldTitle: 'Country', hintText: 'BR')),
              ],
            ),
            LUInputField(
                fieldTitle: 'Cardholder\'s name', hintText: 'Amanda Baggins'),
          ]),
        ),
      );
}

import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The AddCreditCardScreen provides the user with input fields
/// to register a new credit card as a payment option.
class AddCreditCardScreen extends StatelessWidget {
  static const id = 'add_credit_card_screen';

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
        ],
      ),
    ));
  }

//  List<Widget> buildAddCreditCardContent() {
//    return <Widget>[CreditCard()];
//  }
}

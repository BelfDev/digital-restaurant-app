import 'package:dr_app/components/cards/option_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  static const id = 'wallet_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          LUTopBar(
            title: 'Wallet',
            tint: LUTheme.of(context).backgroundColor,
            buttonBackgroundColor: LUTheme.of(context).primaryColor,
          ),
          buildWallerContent()
        ],
      ),
    );
  }

  Widget buildWallerContent() => LUSection(
        margin: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
        titlePadding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
        title: 'Credit Cards',
        child: LUList(
          nested: true,
          items: <Widget>[
            LUOptionCard(leadingIcon: Icons.credit_card, title: 'Card 1')
          ],
        ),
      );
}

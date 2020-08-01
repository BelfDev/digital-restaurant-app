import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/option_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
          buildWallerContent(context)
        ],
      ),
    );
  }

  Widget buildWallerContent(BuildContext context) => Column(
        children: <Widget>[
          LUSection(
            margin: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
            titlePadding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
            title: 'Credit Cards',
            child: LUList(
              nested: true,
              items: <Widget>[
                LUOptionCard(
                  leadingIcon: FontAwesome5Brands.cc_visa,
                  title: 'Visa • 4444',
                  subtitle: 'Selected',
//              onPressed: () {},
//              trailingChildren: <Widget>[
//                RaisedButton(
//                  onPressed: () {
//                    print('Button Test');
//                  },
//                  child: Text('Test'),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: InkWell(
//                    onTap: () {
//                      print('Nice');
//                    },
//                    child: Icon(
//                      FontAwesome5Solid.edit,
//                      color: LUTheme.of(context).primaryColor,
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Icon(
//                    FontAwesome5Solid.trash,
//                    color: LUTheme.of(context).primaryColor,
//                  ),
//                ),
////                LUTileButton(
////                  icon: FontAwesome5Solid.edit,
////                  onPressed: () {
////                    print('edit');
////                  },
////                ),
////                LUTileButton(
////                  icon: FontAwesome5Solid.trash,
////                  onPressed: () {
////                    print('trash');
////                  },
////                ),
//              ],
                ),
                LUOptionCard(
                    leadingIcon: FontAwesome5Brands.cc_mastercard,
                    title: 'Master • 6666')
              ],
            ),
          ),
          LUSolidButton(
            margin: const EdgeInsets.only(top: 28),
            title: 'Add new card',
            onPressed: () {
              print('Add new card');
            },
          )
        ],
      );
}

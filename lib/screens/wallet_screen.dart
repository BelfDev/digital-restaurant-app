import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/buttons/tile_button.dart';
import 'package:dr_app/components/cards/tile_option_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class WalletScreen extends StatefulWidget {
  static const id = 'wallet_screen';

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          LUTopBar(
            title: 'Wallet',
            onNavigationButtonPressed: () => Navigator.of(context).pop(),
            tint: LUTheme.of(context).backgroundColor,
            buttonBackgroundColor: LUTheme.of(context).primaryColor,
          ),
          buildWallerContent(context)
        ],
      ),
    );
  }

  Widget buildWallerContent(BuildContext context) {
    return Column(
      children: <Widget>[
        LUSection(
          margin: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
          titlePadding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
          title: 'Credit Cards',
          child: LUList(
            nested: true,
            items: <Widget>[
              LUTileOptionCard(
                leadingIcon: FontAwesome5Brands.cc_visa,
                title: 'Visa • 4444',
                subtitle: 'Selected',
                trailingChildren: <Widget>[
                  LUTileButton(
                    icon: FontAwesome5Solid.edit,
                    onPressed: () {
                      print('edit');
                    },
                  ),
                  LUTileButton(
                    icon: FontAwesome5Solid.trash,
                    onPressed: () {
                      print('trash');
                    },
                  ),
                ],
              ),
              LUTileOptionCard(
                leadingIcon: FontAwesome5Brands.cc_mastercard,
                title: 'Master • 6666',
                subtitle: 'Selected',
                trailingChildren: <Widget>[
                  LUTileButton(
                    icon: FontAwesome5Solid.edit,
                    onPressed: () {
                      print('edit');
                    },
                  ),
                  LUTileButton(
                    icon: FontAwesome5Solid.trash,
                    onPressed: () {
                      print('trash');
                    },
                  ),
                ],
              ),
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
}

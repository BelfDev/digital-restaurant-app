import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/tile_option_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/screens/edit_profile_screen.dart';
import 'package:dr_app/screens/favorites_screen.dart';
import 'package:dr_app/screens/last_visited_screen.dart';
import 'package:dr_app/screens/wallet_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// The profile screen displays personalized options to the authenticated user.
/// Here the user can navigate to the payment methods,favorite restaurants, and
/// last visited restaurants.
class ProfileScreen extends StatelessWidget {
  static const id = 'profile_screen';

  static const double profilePictureSize = 160;
  static const double headerHeightFactor = 0.30;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          buildProfileHeader(context),
          buildProfileContent(context),
        ],
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * headerHeightFactor + 32,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Styles.roundBackgroundRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Styles.roundBackgroundRadius),
                child: Container(
                  height:
                      MediaQuery.of(context).size.height * headerHeightFactor,
                  color: LUColors.yellow,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.asset(Images.homeHeaderBackground,
                              fit: BoxFit.cover)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Profile', style: Styles.profileTitle),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: profilePictureSize,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          width: profilePictureSize,
                          height: profilePictureSize,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(LUTheme.cardBorderRadius))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                LUTheme.cardBorderRadius - 4),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.verticalPlaceholder,
                              image: 'https://picsum.photos/400/300?random=2',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24, top: 24),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Amanda \n\nBaggins',
                                  style: Styles.sloganTitle,
                                ),
                                FlatButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 4.0),
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(EditProfileScreen.id),
                                  child: Text(
                                    'Edit Profile',
                                    style: Styles.profileButtonText,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget buildProfileContent(BuildContext context) => Expanded(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LUList(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                nested: true,
                items: <Widget>[
                  LUTileOptionCard(
                    leadingIcon: Icons.credit_card,
                    title: 'Wallet',
                    onPressed: () =>
                        Navigator.of(context).pushNamed(WalletScreen.id),
                  ),
                  LUTileOptionCard(
                    leadingIcon: Icons.favorite_border,
                    title: 'Favorite restaurants',
                    onPressed: () =>
                        Navigator.of(context).pushNamed(FavoritesScreen.id),
                  ),
                  LUTileOptionCard(
                    leadingIcon: Icons.history,
                    title: 'Visited restaurants',
                    onPressed: () =>
                        Navigator.of(context).pushNamed(LastVisitedScreen.id),
                  ),
                ],
              ),
              LUSolidButton(
                onPressed: () {},
                title: 'logout',
              )
            ],
          ),
        ),
      );
}

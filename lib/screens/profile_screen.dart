import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const id = 'profile_screen';

  static const double profilePictureSize = 160;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[buildProfileHeader(context)],
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.35 + 32,
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
                  height: MediaQuery.of(context).size.height * 0.35,
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
                                  onPressed: () {},
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
}

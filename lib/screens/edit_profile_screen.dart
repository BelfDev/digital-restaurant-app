import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// The EditProfileScreen makes it possible for the user
/// to edit profile-related information such as fullname,
/// email, and password.
class EditProfileScreen extends StatefulWidget {
  static const id = 'edit_profile_screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const double profilePictureSize = 160;
  static const double headerHeightFactor = 0.30;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          buildEditProfileHeader(context),
          buildEditProfileContent(context),
        ],
      ),
    );
  }

  Widget buildAvatar() => Container(
        width: profilePictureSize,
        height: profilePictureSize,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              )
            ],
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(LUTheme.cardBorderRadius))),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(LUTheme.cardBorderRadius - 4),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.verticalPlaceholder,
                  image: 'https://picsum.photos/400/300?random=2',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.camera_alt,
                size: 80,
                color: LUColors.smoothGray.withOpacity(0.9),
              ),
            ),
          ],
        ),
      );

  Widget buildEditProfileHeader(BuildContext context) => Container(
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
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: profilePictureSize,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildAvatar(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24, top: 24),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Amanda \n\nBaggins',
                              style: Styles.sloganTitle,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SafeArea(
              child: LUTopBar(
                title: 'Edit Profile',
                onNavigationButtonPressed: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      );

  Widget buildEditProfileContent(BuildContext context) => Expanded(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Nice'),
              LUSolidButton(
                onPressed: () {},
                title: 'save',
              )
            ],
          ),
        ),
      );
}

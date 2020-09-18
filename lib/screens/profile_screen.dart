import 'package:dr_app/blocs/auth/auth_bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/tile_option_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_avatar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/navigation/router.dart';
import 'package:dr_app/screens/wallet_screen.dart';
import 'package:dr_app/services/session_manager.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/dialogs.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The profile screen displays personalized options to the authenticated user.
/// Here the user can navigate to the payment methods,favorite restaurants, and
/// last visited restaurants.
class ProfileScreen extends StatefulWidget {
  static const id = 'profile_screen';

  static const double profilePictureSize = 160;
  static const double headerHeightFactor = 0.30;

  final AppRouter router;

  const ProfileScreen({Key key, this.router}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  final _sessionManager = SessionManager();
  AuthBloc authBloc;

  void onLogoutPressed(BuildContext context) {
    Dialogs.showLoadingDialog(context, _keyLoader);
    authBloc.add(LogOutRequested());
  }

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = _sessionManager.isAuthenticated;
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: isAuthenticated
          ? Column(
              children: <Widget>[
                buildProfileHeader(context),
                buildProfileContent(context),
              ],
            )
          : Container(
              child: Center(
                  child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text('Please Login first by tapping on the Profile tab'),
            ))),
    );
  }

  Widget buildProfileHeader(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height *
                ProfileScreen.headerHeightFactor +
            32,
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
                  height: MediaQuery.of(context).size.height *
                      ProfileScreen.headerHeightFactor,
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
                    height: ProfileScreen.profilePictureSize,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LURectangleAvatar(
                          profilePictureSize: ProfileScreen.profilePictureSize,
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
                                  _sessionManager.authEmail ?? 'Full Name',
                                  style: Styles.sloganTitle,
                                ),
                                // FlatButton(
                                //   padding: const EdgeInsets.symmetric(
                                //       vertical: 0.0, horizontal: 4.0),
                                //   child: Text(
                                //     'Edit Profile',
                                //     style: Styles.profileButtonText,
                                //   ),
                                // )
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

  Widget buildProfileContent(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.operationStatus != current.operationStatus,
      listener: (context, state) {
        if (state.operationStatus == ContentStateStatus.loadSuccess &&
            state.status == AuthenticationStatus.unauthenticated) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          widget.router.navigateToAuthentication(context);
        }
      },
      builder: (context, state) {
        return Expanded(
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
                      backgroundColor: Colors.grey.shade200,
                      tint: Colors.grey.shade500,
                      elevation: 0,
                    ),
                    LUTileOptionCard(
                      leadingIcon: Icons.history,
                      title: 'Visited restaurants',
                      backgroundColor: Colors.grey.shade200,
                      tint: Colors.grey.shade500,
                      elevation: 0,
                    ),
                  ],
                ),
                LUSolidButton(
                  title: 'logout',
                  onPressed: _sessionManager.isAuthenticated
                      ? () => onLogoutPressed(context)
                      : null,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

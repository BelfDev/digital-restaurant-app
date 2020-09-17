import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/input_field.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_avatar.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:flutter/material.dart';

/// The SignUpScreen presents the user with a form which
/// can be used to create a new account.
class SignUpScreen extends StatefulWidget {
  static const id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

//TODO: State management and validation
class _SignUpScreenState extends State<SignUpScreen> {
  static const headerHeightFactor = 0.28;
  static const double profilePictureSize = 160;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: LUTheme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            buildSignUpHeaderBackground(),
            buildSignUpBody(context),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height *
                          (headerHeightFactor / 3)),
                  child: LURectangleAvatar(
                    editable: true,
                    profilePictureSize: profilePictureSize,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: LUTopBar(
                title: 'Sign Up',
                onNavigationButtonPressed: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSignUpHeaderBackground() {
    return Container(
      decoration: BoxDecoration(
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
        child: Container(
          height: MediaQuery.of(context).size.height * headerHeightFactor,
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
    );
  }

  Widget buildSignUpBody(BuildContext context) {
    return RoundContainer(
      child: LUList(
        padding: EdgeInsets.only(
            top: profilePictureSize / 2, left: 32.0, right: 32.0),
        items: <Widget>[
          Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LUInputField(
                    fieldTitle: 'Full Name',
                    hintText: 'Amanda Baggins',
                    keyboardType: TextInputType.text,
                  ),
                  LUInputField(
                      fieldTitle: 'Email',
                      hintText: 'amanda@email.com',
                      keyboardType: TextInputType.emailAddress),
                  LUInputField(
                      obscureText: true,
                      fieldTitle: 'Password',
                      hintText: '123456',
                      keyboardType: TextInputType.text),
                  LUInputField(
                      obscureText: true,
                      fieldTitle: 'Repeat Password',
                      hintText: '123456',
                      keyboardType: TextInputType.text),
                ]),
          ),
          LUSolidButton(
            margin: EdgeInsets.only(top: 24.0),
            title: 'Sign Up',
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}

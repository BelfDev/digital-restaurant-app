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

class _SignUpScreenState extends State<SignUpScreen> {
  static const headerHeightFactor = 0.28;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[buildHeaderBackground()],
      ),
    );
  }

  Widget buildHeaderBackground() {
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
}

import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The LoginScreen displays an input form which
/// allows users to authenticate using their account credentials.
class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
    );
  }
}

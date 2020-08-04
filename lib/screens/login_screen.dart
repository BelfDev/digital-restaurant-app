import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:flutter/material.dart';

/// The LoginScreen displays an input form which
/// allows users to authenticate using their account credentials.
class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const headerHeightFactor = 0.28;
  static const footerHeightFactor = 0.28;
  static const shapeBorderRadius = Radius.elliptical(720, 360);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[
          buildLoginHeader(),
          buildLoginBody(),
          buildLoginFooter()
        ],
      ),
    );
  }

  Widget buildLoginHeader() {
    return _LoginBackgroundShape(
        shapeBorderRadius: shapeBorderRadius,
        context: context,
        headerHeightFactor: headerHeightFactor);
  }

  Widget buildLoginBody() {
    return SizedBox();
  }

  Widget buildLoginFooter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _LoginBackgroundShape(
          invert: true,
          shapeBorderRadius: shapeBorderRadius,
          context: context,
          headerHeightFactor: footerHeightFactor),
    );
  }
}

class _LoginBackgroundShape extends StatelessWidget {
  final Radius shapeBorderRadius;
  final BuildContext context;
  final double headerHeightFactor;
  final bool invert;

  const _LoginBackgroundShape({
    Key key,
    @required this.shapeBorderRadius,
    @required this.context,
    @required this.headerHeightFactor,
    this.invert = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = invert
        ? BorderRadius.only(topLeft: shapeBorderRadius)
        : BorderRadius.only(bottomRight: shapeBorderRadius);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, invert ? -2 : 2), // changes position of shadow
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
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

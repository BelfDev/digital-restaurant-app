import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class _CuisineScreenStyles {
  static const topBarPadding =
      const EdgeInsets.only(left: 16, right: 16, top: 8);
  static const double headerHeight = 200;
}

class CuisineScreen extends StatefulWidget {
  static const id = 'cuisine_screen';

  @override
  _CuisineScreenState createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      bottom: false,
      child: ListView(
        children: <Widget>[
          _buildHeader(args),
        ],
      ),
    );
  }

  Widget _buildHeader(ScreenArguments args) => Container(
        height: _CuisineScreenStyles.headerHeight,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FadeInImage.assetNetwork(
                placeholder: 'res/images/horizontal-placeholder.png',
                image: args.coverImgSrc,
                fit: BoxFit.cover,
              ),
            ),
            _buildTopBar(),
          ],
        ),
      );

  Widget _buildTopBar() => Padding(
      padding: _CuisineScreenStyles.topBarPadding,
      child: Row(
        children: <Widget>[
          LUIconButton(
            icon: Icons.arrow_back_ios,
            onPressed: _onBackButtonPressed,
            tint: LUColors.navyBlue,
            backgroundColor: LUColors.smoothWhite,
          ),
        ],
      ));
}

//class _CuisineScreenState extends State<CuisineScreen> {
//  void _onBackButtonPressed(context) {
//    Navigator.of(context).pop();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//        bottom: false,
//        child: Container(
//          color: Colors.blue,
//        ));
//  }
//}

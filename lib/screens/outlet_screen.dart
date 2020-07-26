import 'package:dr_app/components/buttons/slider_button.dart';
import 'package:dr_app/components/swiper.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class OutletScreen extends StatefulWidget {
  static const id = 'outlet_screen';

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  void _onBackButtonPressed() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildHeader(args),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 40.0,
              child: LUSliderButton(
                margin: Styles.fixedButtonMargin,
                title: 'Check-in',
                onSlided: () {},
              ))
        ],
      ),
    );
  }

  Widget buildHeader(ScreenArguments args) => Container(
        height: 400,
        child: Stack(
          children: <Widget>[
            LUSwiper(imgSrcList: dummySwiperImages),
            LUTopBar(
              onNavigationButtonPressed: _onBackButtonPressed,
            ),
          ],
        ),
      );
}

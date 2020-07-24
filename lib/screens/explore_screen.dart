import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/outline_button.dart';
import 'package:dr_app/components/buttons/slider_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  static const id = 'explore_screen';
  final double space = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LUSliderButton(
          onSlided: () {},
          title: 'check-in',
        ),
        SizedBox(
          height: space,
        ),
        LUSolidButton(
          title: 'Solid',
          onPressed: () {},
        ),
        SizedBox(
          height: space,
        ),
        LUOutlineButton(
          title: 'Outline',
          onPressed: () {},
        ),
        SizedBox(
          height: space,
        ),
        LUIconButton(
          icon: Icons.account_circle,
          onPressed: () {},
        ),
      ],
    ));
  }
}

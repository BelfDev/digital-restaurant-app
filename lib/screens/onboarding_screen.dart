import 'package:dr_app/components/buttons/outline_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/swiper.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:dr_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

/// The OnboardingScreen contains a set of slides
/// showcasing what the App has to offer.
class OnboardingScreen extends StatefulWidget {
  static const id = "onboarding_screen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

//class _OnboardingScreenState extends State<OnboardingScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: LUTheme.of(context).backgroundColor,
//      child: SafeArea(
//          child: Column(
//        children: <Widget>[
//          Text('NICE'),
//          LUSolidButton(
//            title: 'Go to app',
//            onPressed: () => Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(builder: (context) => RootContainer()),
//                (_) => false),
//          )
//        ],
//      )),
//    );
//  }
//}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: LUTheme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(flex: 7, child: LUSwiper(imgSrcList: dummySwiperImages)),
            Expanded(flex: 3, child: buildButtons())
          ],
        ));
  }

  Widget buildButtons() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LUSolidButton(
              title: "Login",
              onPressed: () => Navigator.of(context).pushNamed(LoginScreen.id),
            ),
            SizedBox(
              height: 16,
            ),
            LUOutlineButton(
              title: "Skip",
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => RootContainer()),
                  (_) => false),
            )
          ],
        ),
      );
}

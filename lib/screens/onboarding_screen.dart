import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/navigation/root_container.dart';
import 'package:flutter/material.dart';

/// The OnboardingScreen contains a set of slides
/// showcasing what the App has to offer.
class OnboardingScreen extends StatefulWidget {
  static const id = "onboarding_screen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LUTheme.of(context).backgroundColor,
      child: SafeArea(
          child: Column(
        children: <Widget>[
          Text('NICE'),
          LUSolidButton(
            title: 'Go to app',
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RootContainer()),
                (_) => false),
          )
        ],
      )),
    );
  }
}

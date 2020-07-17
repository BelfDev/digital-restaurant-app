import 'package:dr_app/src/components/buttons/slider_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: LUSliderButton(
          title: "check-in",
          semanticTitle: 'check-in',
          onSlided: () {
            print('Slided!');
          },
        )),
      ),
    );
  }
}

//import 'package:dr_app/src/components/buttons/solid_button.dart';
import 'package:dr_app/src/components/buttons/slide_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

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

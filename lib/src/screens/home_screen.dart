import 'package:dr_app/src/components/buttons/base_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: BaseButton('Home Screen')),
      ),
    );
  }
}

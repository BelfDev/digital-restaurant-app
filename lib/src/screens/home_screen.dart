//import 'package:dr_app/src/components/buttons/solid_button.dart';
import 'package:dr_app/src/components/buttons/outline_button.dart';
import 'package:flutter/material.dart';

//class HomeScreen extends StatelessWidget {
//  static const id = 'home_screen';
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        child: Center(
//            child: SolidButton(
//          title: 'Hello World',
//          color: Color(0xFF4F5D75),
//          onPressed: () {},
//        )),
//      ),
//    );
//  }
//}

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: LUOutlineButton(
          onPressed: () {},
          title: 'Hello World',
        )),
      ),
    );
  }
}

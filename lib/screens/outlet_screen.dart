import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:flutter/material.dart';

class OutletScreen extends StatefulWidget {
  static const id = 'outlet_screen';

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      color: Colors.orange,
    );
  }
}

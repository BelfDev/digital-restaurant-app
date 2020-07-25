import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const id = 'product_screen';
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(args.title),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;

  BaseButton(this.title);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text(title),
    );
  }
}

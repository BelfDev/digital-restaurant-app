import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatelessWidget {
  static const id = "category_detail_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          "Category Detail Screen",
          style: TextStyle(color: Colors.white, fontSize: 40),
        )),
      ),
    );
  }
}

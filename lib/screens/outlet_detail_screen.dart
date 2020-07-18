import 'package:flutter/material.dart';

class OutletDetailScreen extends StatelessWidget {
  static const id = "outlet_detail_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          "Outlet Detail Screen",
          style: TextStyle(color: Colors.white, fontSize: 40),
        )),
      ),
    );
  }
}

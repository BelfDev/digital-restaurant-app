import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  static const id = "scanner_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          "Scanner Screen",
          style: TextStyle(color: Colors.white, fontSize: 40),
        )),
      ),
    );
  }
}

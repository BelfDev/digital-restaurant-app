import 'package:dr_app/components/components.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  contentPadding: EdgeInsets.zero,
                  titlePadding: EdgeInsets.zero,
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Center(child: LULoadingPlaceholder()),
                    )
                  ]));
        });
  }
}

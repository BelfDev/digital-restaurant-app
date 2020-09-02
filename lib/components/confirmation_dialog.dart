import 'dart:io';

import 'package:dr_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A customised [AlertDialog] prompting the user to take an important decision.
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key key,
    @required this.title,
    @required this.message,
    @required this.onConfirmPressed,
    this.onCancelPressed,
    @required this.confirmActionTitle,
    this.cancelActionTitle = "Cancel",
  })  : assert(title != null),
        assert(message != null),
        assert(confirmActionTitle != null),
        super(key: key);

  final String title;
  final String message;
  final String confirmActionTitle;
  final String cancelActionTitle;
  final VoidCallback onConfirmPressed;
  final VoidCallback onCancelPressed;

  bool get _hasConfirmAction => onConfirmPressed != null;

  void _onCancelPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog(context);
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[
        _buildCancelButton(context),
        if (_hasConfirmAction) _buildConfirmButton()
      ],
    );
  }

  Widget _buildMaterialDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Styles.dialogTitle,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[_buildCancelButton(context), _buildConfirmButton()],
    );
  }

  Widget _buildConfirmButton() {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              confirmActionTitle,
              style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: onConfirmPressed,
          )
        : FlatButton(
            child: Text(
              confirmActionTitle,
              style: Styles.dialogAction,
            ),
            onPressed: onConfirmPressed,
          );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              cancelActionTitle,
              style: TextStyle(
                  color: CupertinoColors.destructiveRed,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: onCancelPressed ?? () => _onCancelPressed(context))
        : FlatButton(
            child: Text(
              cancelActionTitle,
              style: Styles.dialogAction,
            ),
            onPressed: onCancelPressed ?? () => _onCancelPressed(context));
  }
}

import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A container for a screen section. Automatically styles the
/// given title and the relevant margins.
class LUSection extends StatelessWidget {
  final String title;
  final WidgetBuilder builder;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry titlePadding;

  const LUSection(
      {Key key,
      @required this.title,
      @required this.builder,
      this.margin = const EdgeInsets.only(top: 16.0),
      this.titlePadding = const EdgeInsets.only(left: 18.0, bottom: 8.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: titlePadding,
            child: Text(
              title,
              style: Styles.sectionText,
            ),
          ),
          builder(context),
        ],
      ),
    );
  }
}

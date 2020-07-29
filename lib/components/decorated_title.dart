import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// A convenience widget which builds a customised text with
/// decorator icons on its edges.
class LUDecoratedTitle extends StatelessWidget {
  final String title;

  const LUDecoratedTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Ionicons.ios_reorder,
          size: 28,
          color: LUTheme.of(context).unselectedWidgetColor,
        ),
        Text(
          title,
          style: LUTheme.of(context).textTheme.headline5.copyWith(
              color: LUTheme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Icon(Ionicons.ios_reorder,
            size: 28, color: LUTheme.of(context).unselectedWidgetColor),
      ],
    );
  }
}

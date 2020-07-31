import 'package:dr_app/components/cards/base_card.dart';
import 'package:flutter/material.dart';

/// A customized material [Card] with a [ListTile] as its children.
/// This widget is often used as a compact [LUList] item.
class LUOptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LUBaseCard(
      children: <Widget>[
        ListTile(
          title: Text('Nice'),
        ),
      ],
    );
  }
}

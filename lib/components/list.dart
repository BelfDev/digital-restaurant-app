import 'package:flutter/material.dart';

/// Customised material [ListView] to hold Lutick components such as [LUOutletCard]s
class LUList extends StatelessWidget {
  final double space;
  final List<Widget> items;
  final EdgeInsetsGeometry padding;
  final bool nested;

  const LUList(
      {Key key,
      @required this.items,
      this.space = 8.0,
      this.padding,
      this.nested})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: nested ? ClampingScrollPhysics() : BouncingScrollPhysics(),
        padding: padding ?? EdgeInsets.zero,
        shrinkWrap: nested ?? false,
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: space,
              thickness: 0,
              color: Colors.transparent,
            ),
        itemBuilder: (context, index) => items[index]);
  }
}

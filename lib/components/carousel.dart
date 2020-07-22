import 'package:flutter/material.dart';

class LUCarousel extends StatelessWidget {
  final double width;
  final double height;
  final double space;
  final List<Widget> items;
  final EdgeInsetsGeometry padding;

  const LUCarousel(
      {Key key,
      this.width,
      @required this.height,
      this.padding = const EdgeInsets.only(left: 16, right: 16, top: 24),
      @required this.items,
      this.space = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ListView.separated(
          padding: padding ?? EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index) =>
              VerticalDivider(
                width: space,
                thickness: 0,
                color: Colors.transparent,
              ),
          itemBuilder: (context, index) => items[index]),
    );
  }
}

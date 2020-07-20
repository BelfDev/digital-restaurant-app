import 'package:flutter/material.dart';

class LUCarousel extends StatelessWidget {
  final double width;
  final double height;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const LUCarousel(
      {Key key,
      this.width,
      @required this.height,
      this.padding = const EdgeInsets.only(left: 16, right: 16, top: 24),
      @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ListView(
        padding: padding,
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    );
  }
}

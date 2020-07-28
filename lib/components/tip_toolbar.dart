import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A bar containing buttons to select the desired tip value.
class LUTipToolbar extends StatelessWidget {
  final List<String> tipOptions;
  final EdgeInsetsGeometry margin;

  const LUTipToolbar({Key key, this.tipOptions, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List indexList =
        Iterable<int>.generate(tipOptions.length + tipOptions.length - 1)
            .toList();

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
            color: LUTheme.of(context).unselectedWidgetColor,
            borderRadius: BorderRadius.circular(LUTheme.buttonBorderRadius)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: indexList.map((index) {
              if (index % 2 != 0) {
                return VerticalDivider(
                  width: 4,
                  indent: 4,
                  endIndent: 4,
                  color: const Color(0X443C3C43),
                );
              }
              return Container(
                color: LUTheme.of(context).unselectedWidgetColor,
                child: Center(
                    child: Text(
                  tipOptions[(index ~/ 2) % tipOptions.length],
                  style: Styles.tipLabel,
                )),
              );
            }).toList()),
      ),
    );
  }
}

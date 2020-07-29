import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/tip.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A bar containing buttons to select the desired tip value.
class LUTipToolbar extends StatefulWidget {
  final List<Tip> tipOptions;
  final EdgeInsetsGeometry margin;
  final ValueChanged<Tip> onPressed;

  const LUTipToolbar({Key key, this.tipOptions, this.margin, this.onPressed})
      : super(key: key);

  @override
  _LUTipToolbarState createState() => _LUTipToolbarState();
}

class _LUTipToolbarState extends State<LUTipToolbar> {
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final List indexList = Iterable<int>.generate(
            widget.tipOptions.length + widget.tipOptions.length - 1)
        .toList();

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
            color: LUTheme.of(context).unselectedWidgetColor,
            borderRadius: BorderRadius.circular(LUTheme.buttonBorderRadius)),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(LUTheme.buttonBorderRadius)),
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

                final currentIndex = (index ~/ 2) % widget.tipOptions.length;

                return Expanded(
                  child: MaterialButton(
                    color: selectedIndex == currentIndex
                        ? LUTheme.of(context).accentColor
                        : null,
                    onPressed: () {
                      setState(() {
                        selectedIndex = currentIndex;
                      });
                      widget.onPressed(widget.tipOptions[currentIndex]);
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        widget
                            .tipOptions[(index ~/ 2) % widget.tipOptions.length]
                            .displayText,
                        style: selectedIndex == currentIndex
                            ? Styles.tipLabel.copyWith(
                                color: LUTheme.of(context).backgroundColor)
                            : Styles.tipLabel,
                      )),
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}

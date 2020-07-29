import 'package:dr_app/components/buttons/slider_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum BottomSliverButton { SOLID, SLIDER }

/// A bottom bar which displays summary cart information such as
/// subtotal and tip. This widget also contains an action button
/// of type [LUSliderButton] or [LUSolidButton].
class LUBottomSliver extends StatelessWidget {
  final double subtotal;
  final double tip;
  final String buttonTitle;
  final VoidCallback onButtonPressed;
  final BottomSliverButton buttonType;

  const LUBottomSliver(
      {Key key,
      this.subtotal = 0,
      this.tip,
      @required this.buttonTitle,
      @required this.onButtonPressed,
      this.buttonType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 4), // changes position of shadow
              )
            ],
            color: LUColors.smoothWhite,
            border:
                Border(top: BorderSide(width: 1, color: LUColors.smoothGray))),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 32.0, right: 32.0, bottom: 40.0, top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              tip != null ? buildTip() : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: Styles.sectionText,
                  ),
                  Text(subtotal.toString(), style: Styles.sectionText)
                ],
              ),
              buildButton()
            ],
          ),
        ));
  }

  Widget buildButton() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      child: buttonType == BottomSliverButton.SLIDER
          ? LUSliderButton(
              key: ValueKey<BottomSliverButton>(buttonType),
              title: buttonTitle,
              onSlided: onButtonPressed,
            )
          : LUSolidButton(
              key: ValueKey<BottomSliverButton>(buttonType),
              title: buttonTitle,
              onPressed: onButtonPressed,
            ));

  Widget buildTip() {
    final double tipIncludedDisplay = tip * 100;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Tip Included',
          style: Styles.tipIncludedText,
        ),
        Text("$tipIncludedDisplay%", style: Styles.tipIncludedText)
      ],
    );
  }
}

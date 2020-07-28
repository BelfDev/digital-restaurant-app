import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// The contents of a [BottomSheet]. This widget is displayed
/// over a screen to request for user input.
class LUBottomSheetContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const LUBottomSheetContainer(
      {Key key, @required this.title, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LUTheme.bottomSheetRadius),
          topRight: Radius.circular(LUTheme.bottomSheetRadius)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: LUColors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 64,
              decoration: BoxDecoration(
                  color: LUTheme.of(context).unselectedWidgetColor,
                  border: Border(
                      bottom: BorderSide(width: 1, color: LUColors.gray))),
              child: Center(
                child: Text(
                  title,
                  style: Styles.bottomSheetTitle,
                ),
              ),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children),
            )
          ],
        ),
      ),
    );
  }
}

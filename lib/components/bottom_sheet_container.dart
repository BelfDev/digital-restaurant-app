import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class LUBottomSheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LUTheme.bottomSheetRadius),
          topRight: Radius.circular(LUTheme.bottomSheetRadius)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
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
                  'Choose payment',
                  style: Styles.bottomSheetTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

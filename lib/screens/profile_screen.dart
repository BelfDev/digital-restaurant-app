import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[buildProfileHeader(context)],
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.only(bottomLeft: Styles.roundBackgroundRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            )
          ],
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.only(bottomLeft: Styles.roundBackgroundRadius),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            color: LUColors.yellow,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.asset(Images.homeHeaderBackground,
                        fit: BoxFit.cover)),
              ],
            ),
          ),
        ),
      );
}

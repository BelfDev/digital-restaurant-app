import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

class LUCompactHeader extends StatelessWidget {
  final String imgSrc;
  final VoidCallback onTopButtonPressed;

  const LUCompactHeader({Key key, this.imgSrc, this.onTopButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Styles.compactHeaderHeight,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FadeInImage.assetNetwork(
              placeholder: Images.horizontalPlaceholder,
              image: imgSrc,
              fit: BoxFit.cover,
            ),
          ),
          LUTopBar(
            onNavigationButtonPressed: onTopButtonPressed,
          ),
        ],
      ),
    );
  }
}

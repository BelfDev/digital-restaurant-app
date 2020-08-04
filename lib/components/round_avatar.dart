import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:flutter/material.dart';

/// A round rectangle container which displays an image source.
/// Often used to display a user's profile picture.
class LURectangleAvatar extends StatelessWidget {
  final double profilePictureSize;
  final bool editable;

  const LURectangleAvatar({
    Key key,
    @required this.profilePictureSize,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: profilePictureSize,
        height: profilePictureSize,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 2), // changes position of shadow
              )
            ],
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(LUTheme.cardBorderRadius))),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(LUTheme.cardBorderRadius - 4),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.verticalPlaceholder,
                  image: 'https://picsum.photos/400/300?random=2',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            editable
                ? Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: LUColors.smoothGray.withOpacity(0.9),
                    ),
                  )
                : SizedBox()
          ],
        ),
      );
}

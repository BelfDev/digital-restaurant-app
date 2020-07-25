import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

abstract class _CuisineScreenStyles {
  static const topBarPadding =
      const EdgeInsets.only(left: 16, right: 16, top: 8);
  static const double headerHeight = 240;
  static const backgroundBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(40), topRight: Radius.circular(40));
}

class CuisineScreen extends StatefulWidget {
  static const id = 'cuisine_screen';

  @override
  _CuisineScreenState createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  List<Widget> _getOutletCards() => dummyOutlets
      .map((outlet) => LUOutletCard(
            imageSrc: outlet.imgSrc,
            rating: outlet.rating,
            title: outlet.name,
            priceRange: outlet.priceRange,
            onPressed: () {},
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return ListView(
      padding: EdgeInsets.zero,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildHeader(args),
            _buildContent(args),
          ],
        )
      ],
    );
  }

  Widget _buildHeader(ScreenArguments args) => Container(
        height: _CuisineScreenStyles.headerHeight,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FadeInImage.assetNetwork(
                placeholder: Images.horizontalPlaceholder,
                image: args.coverImgSrc,
                fit: BoxFit.cover,
              ),
            ),
            _buildTopBar(),
          ],
        ),
      );

  Widget _buildTopBar() => SafeArea(
        bottom: false,
        child: Padding(
            padding: _CuisineScreenStyles.topBarPadding,
            child: Row(
              children: <Widget>[
                LUIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: _onBackButtonPressed,
                  tint: LUColors.navyBlue,
                  backgroundColor: LUColors.smoothWhite,
                ),
              ],
            )),
      );

  Widget _buildContent(ScreenArguments args) => RoundContainer(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Ionicons.ios_reorder,
                  size: 28,
                  color: LUTheme.of(context).unselectedWidgetColor,
                ),
                Text(
                  args.title,
                  style: LUTheme.of(context).textTheme.headline5.copyWith(
                      color: LUTheme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Ionicons.ios_reorder,
                    size: 28, color: LUTheme.of(context).unselectedWidgetColor),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Ionicons.ios_pin,
                  size: 20,
                  color: LUColors.darkBlue,
                ),
                Text(
                  'Glasgow',
                  style: Styles.location,
                ),
                SizedBox(
                  width: 8,
                )
              ],
            ),
            LUList(
              padding: EdgeInsets.only(top: 24),
              nested: true,
              space: 10,
              items: _getOutletCards(),
            ),
          ],
        ),
      );
}

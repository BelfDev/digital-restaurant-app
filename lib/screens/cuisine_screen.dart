import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/screen_arguments.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/images.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// The Cuisine screen displays a list of cards representing
/// outlets which belong to the selected cuisine category.
abstract class _CuisineScreenStyles {
  static const double headerHeight = 240;
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
            LUTopBar(
              onNavigationButtonPressed: _onBackButtonPressed,
            ),
          ],
        ),
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
                  style: Styles.locationText,
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

import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/compact_header.dart';
import 'package:dr_app/components/decorated_title.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/data/dummy/dummy_data.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// The Cuisine screen displays a list of cards representing
/// outlets which belong to the selected cuisine category.
class CuisineScreen extends StatelessWidget {
  static const id = 'cuisine_screen';

  final Cuisine cuisine;

  const CuisineScreen(this.cuisine, {Key key}) : super(key: key);

  List<Widget> _getOutletCards() => dummyOutlets
      .map((outlet) => LUOutletCard(
            imageSrc: outlet.imgSrc,
            rating: outlet.rating,
            title: outlet.name,
            priceRange: outlet.priceRange ?? 0,
            onPressed: () {},
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OutletBloc, OutletState>(
      listener: (context, state) {
        if (state.status == ContentStateStatus.initial) {
          BlocProvider.of<OutletBloc>(context).add(OutletsRequested());
        }
      },
      builder: (context, state) {
        final outlets = state.outlets;

        return ListView(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Stack(
              children: <Widget>[
                LUCompactHeader(
                  imgSrc: cuisine.image.source ?? '',
                  icon: Icons.arrow_back_ios,
                  onTopButtonPressed: () => Navigator.of(context).pop(),
                ),
                _buildContent(cuisine.title),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildContent(String title) => RoundContainer(
        child: Column(
          children: <Widget>[
            LUDecoratedTitle(
              title: title,
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

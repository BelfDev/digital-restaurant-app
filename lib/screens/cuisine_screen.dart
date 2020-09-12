import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/compact_header.dart';
import 'package:dr_app/components/components.dart';
import 'package:dr_app/components/decorated_title.dart';
import 'package:dr_app/components/list.dart';
import 'package:dr_app/components/round_container.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/screens/outlet_screen.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// The Cuisine screen displays a list of cards representing
/// outlets which belong to the selected cuisine category.
class CuisineScreen extends StatefulWidget {
  static const id = 'cuisine_screen';

  final Cuisine cuisine;

  const CuisineScreen(this.cuisine, {Key key}) : super(key: key);

  @override
  _CuisineScreenState createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  OutletBloc outletBloc;
  List<Outlet> outlets;

  @override
  void initState() {
    super.initState();
    outletBloc = BlocProvider.of<OutletBloc>(context)
      ..add(OutletsRequested(cuisine: widget.cuisine.title));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Stack(
          children: <Widget>[
            LUCompactHeader(
              imgSrc: widget.cuisine?.image?.source ?? '',
              icon: Icons.arrow_back_ios,
              onTopButtonPressed: () => Navigator.of(context).pop(),
            ),
            _buildContent(widget.cuisine.title),
          ],
        )
      ],
    );
  }

  Widget _buildContent(String title) {
    return RoundContainer(
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
          buildOutletsList(),
        ],
      ),
    );
  }

  Widget buildOutletsList() {
    return BlocBuilder<OutletBloc, OutletState>(
      builder: (context, state) {
        return LULoadableContent(
          height: 300,
          stateStatus: state.status,
          contentBuilder: () {
            if (state.outlets != null) {
              outlets = state.outlets;
            }

            if (outlets == null) {
              return Container();
            }

            return LUList(
              padding: EdgeInsets.only(top: 24),
              nested: true,
              space: 10,
              items: outlets
                  .map(
                    (outlet) => LUOutletCard(
                      imageSrc: outlet.images?.first?.source ?? '',
                      rating: outlet.rating,
                      title: outlet.title,
                      priceRange: outlet.priceLevel,
                      onPressed: () async {
                        final result = await Navigator.of(context).pushNamed(
                          OutletScreen.id,
                          arguments: outlet,
                        );
                        if (result != null) {
                          Navigator.pop(context, result);
                        }
                      },
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}

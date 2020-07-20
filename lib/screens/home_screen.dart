import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dummyCards = [
    'Restaurant 1',
    'Restaurant 2',
    'Restaurant 3',
    'Restaurant 4',
    'Restaurant 5',
    'Restaurant 6',
    'Restaurant 7',
    'Restaurant 8',
    'Restaurant 9',
    'Restaurant 10'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: ListView(
        children: <Widget>[
          _buildTopBar(),
          Stack(
            children: <Widget>[_buildHeader(), _buildContent()],
          )
        ],
      ),
    );
  }

  Widget _buildTopBar() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Le Serveur',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            LUIconButton(
              icon: Icons.center_focus_strong,
              iconSize: 32,
              onPressed: () {
                print('Pressed On Scanner');
              },
            )
          ],
        ),
      );

  Widget _buildHeader() => Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.only(top: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.yellow,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20))),
              Text(
                'Time to get\nsome food',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );

  Widget _buildContent() => Container(
      margin: EdgeInsets.only(top: 200),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(children: <Widget>[
          LUSolidButton(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32),
              color: Color(0xFF4F5D75),
              title: "Find a Restaurant",
              onPressed: () {}),
          _buildFeaturedCarousel(),
          ..._getCards(),
        ]),
      ));

  List<Widget> _getCards() => dummyCards
      .map((title) => Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LUOutletCard(
              rating: 4,
              title: title,
              priceRange: '\$\$',
              onPressed: () {},
            ),
          ))
      .toList();

  Widget _buildFeaturedCarousel() => Container(
        height: 200,
        child: ListView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 24),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            LUCategoryCard(
              title: 'italian',
            ),
            LUCategoryCard(
              title: 'Brazilian',
            ),
            LUCategoryCard(
              title: 'Brazilian',
            ),
            LUCategoryCard(
              title: 'Brazilian',
            ),
            LUCategoryCard(
              title: 'Brazilian',
            ),
          ],
        ),
      );
}

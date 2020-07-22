import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/cards/featured_card.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/carousel.dart';
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
            Image.asset(
              'res/images/logo.png',
              width: 227,
              height: 46,
              fit: BoxFit.cover,
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
              Image.asset(
                'res/images/home-chef.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
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
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: LUSolidButton(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32),
              color: Color(0xFF4F5D75),
              title: "Find a Restaurant",
              onPressed: () {}),
        ),
        _buildSection("Chef's choice - Glasgow", 300, <Widget>[
          LUFeaturedCard(
            imageSrc: 'https://picsum.photos/200',
            title: 'Bar Soba',
            subtitle: 'Asian Fusion',
            onPressed: () {},
            rating: 4,
            priceRange: '\$\$',
          ),
          LUFeaturedCard(
            imageSrc: 'https://picsum.photos/0',
            title: 'italian',
            subtitle: 'nicee',
            onPressed: () {},
            rating: 4,
            priceRange: '\$\$',
          ),
          LUFeaturedCard(
            imageSrc: 'https://picsum.photos/1000',
            title: 'italian',
            subtitle: 'nicee',
            onPressed: () {},
            rating: 4,
            priceRange: '\$\$',
          ),
          LUFeaturedCard(
            imageSrc: 'https://picsum.photos/1001',
            title: 'italian',
            subtitle: 'nicee',
            onPressed: () {},
            rating: 4,
            priceRange: '\$\$',
          ),
        ]),
        _buildSection('Cuisines', 160, <Widget>[
          LUCategoryCard(
            title: 'Italian',
            imageSrc: 'https://picsum.photos/102',
          ),
          LUCategoryCard(
              title: 'Brazilian', imageSrc: 'https://picsum.photos/108'),
          LUCategoryCard(
              title: 'Japanese', imageSrc: 'https://picsum.photos/110'),
          LUCategoryCard(title: 'Greek', imageSrc: 'https://picsum.photos/222'),
        ]),
        ..._getCards(),
      ]));

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

  Widget _buildSection(String title, double height, List<Widget> items) =>
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
            LUCarousel(
                height: height,
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                children: items)
          ],
        ),
      );
}

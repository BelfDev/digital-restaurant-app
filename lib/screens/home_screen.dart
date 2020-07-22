import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/components/buttons/solid_button.dart';
import 'package:dr_app/components/cards/category_card.dart';
import 'package:dr_app/components/cards/featured_card.dart';
import 'package:dr_app/components/cards/outlet_card.dart';
import 'package:dr_app/components/carousel.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
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
              icon: MaterialCommunityIcons.qrcode_scan,
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
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: LUColors.yellow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset('res/images/header-bg.png',
                      fit: BoxFit.fill)),
              Positioned.fill(
                bottom: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'res/images/home-chef.png',
                      height: 128,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: 'Time to get\nsome ',
                              style: TextStyle(
                                  color: LUColors.navyBlue,
                                  fontSize: 28,
                                  height: 0.5,
                                  fontFamily: 'Lora')),
                          TextSpan(
                              text: 'food',
                              style: TextStyle(
                                  color: LUColors.navyBlue,
                                  fontSize: 36,
                                  fontFamily: 'Lora',
                                  fontWeight: FontWeight.w700))
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildContent() => Container(
      margin: EdgeInsets.only(top: 192),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: LUSolidButton(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32),
              color: LUColors.navyBlue,
              title: "Find a Restaurant",
              onPressed: () {}),
        ),
        _buildHorizontalSection("Chef's choice - Glasgow", 280, <Widget>[
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
        _buildHorizontalSection('Cuisines', 160, <Widget>[
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
        _buildVerticalSection('Nearby Restaurants', _getCards()),
      ]));

  List<Widget> _getCards() => dummyCards
      .map((title) => Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LUOutletCard(
              imageSrc: 'https://picsum.photos/200/300',
              rating: 4,
              title: title,
              priceRange: '\$\$',
              onPressed: () {},
            ),
          ))
      .toList();

  Widget _buildHorizontalSection(
          String title, double height, List<Widget> items) =>
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

  Widget _buildVerticalSection(String title, List<Widget> items) => Padding(
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
              ...items,
            ]),
      );
}

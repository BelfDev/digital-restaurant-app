import 'package:dr_app/components/cards/featured_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Center(
                child: LUFeaturedCard(
          imageSrc: 'https://placeimg.com/640/480/any',
          onPressed: () {
            print('tapped');
          },
          title: 'Bar Soba',
          subtitle: 'Asian Food',
          priceRange: '\$\$',
          rating: 4,
        ))),
      ),
    );
  }
}

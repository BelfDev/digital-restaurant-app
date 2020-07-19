import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dummyCards = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: ListView(
        children: <Widget>[_buildTopBar(), _buildHeader()],
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
      margin: EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.yellow,
      ),
      child: _buildContent());

  Widget _buildContent() => Container(
        height: 1000,
        margin: EdgeInsets.only(top: 200),
        decoration: BoxDecoration(
//              color: Color(0xFFFAFAFA),
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
      );
}

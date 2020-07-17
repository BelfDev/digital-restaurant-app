import 'package:dr_app/src/navigation/tab_data.dart';
import 'package:dr_app/src/screens/explore_screen.dart';
import 'package:dr_app/src/screens/home_screen.dart';
import 'package:dr_app/src/screens/more_screen.dart';
import 'package:dr_app/src/screens/profile_screen.dart';
import 'package:flutter/material.dart';

/// A list of TabData used for configuring the application's [BottomNavigationBar].
const List<TabData> tabs = <TabData>[
  TabData(0, HomeScreen.id, 'Home', Icons.restaurant, Colors.teal),
  TabData(1, ExploreScreen.id, 'Explore', Icons.explore, Colors.cyan),
  TabData(2, ProfileScreen.id, 'Profile', Icons.person_pin, Colors.orange),
  TabData(3, MoreScreen.id, 'More', Icons.more_horiz, Colors.blue)
];

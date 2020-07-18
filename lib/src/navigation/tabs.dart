import 'package:dr_app/src/navigation/tab_data.dart';
import 'package:dr_app/src/screens/explore_screen.dart';
import 'package:dr_app/src/screens/home_screen.dart';
import 'package:dr_app/src/screens/more_screen.dart';
import 'package:dr_app/src/screens/profile_screen.dart';
import 'package:flutter/material.dart';

/// A list of TabData used for configuring the application's [BottomNavigationBar].
const List<TabData> tabs = <TabData>[
  TabData(0, HomeScreen.id, 'Home', Icons.restaurant),
  TabData(1, ExploreScreen.id, 'Explore', Icons.explore),
  TabData(2, ProfileScreen.id, 'Profile', Icons.person_pin),
  TabData(3, MoreScreen.id, 'More', Icons.more_horiz),
];

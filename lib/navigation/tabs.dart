import 'package:dr_app/navigation/tab_data.dart';
import 'package:dr_app/screens/explore_screen.dart';
import 'package:dr_app/screens/home_screen.dart';
import 'package:dr_app/screens/more_screen.dart';
import 'package:dr_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

/// A list of TabData used for configuring the application's [BottomNavigationBar].
const List<TabData> tabs = <TabData>[
  TabData(0, HomeScreen.id, 'Home', Icons.restaurant),
  TabData(1, ExploreScreen.id, 'Explore', Icons.explore),
  TabData(2, ProfileScreen.id, 'Profile', Icons.account_circle),
  TabData(3, MoreScreen.id, 'More', Icons.more_horiz),
];

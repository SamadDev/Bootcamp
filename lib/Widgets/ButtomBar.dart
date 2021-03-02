import 'package:bootcamps/Pages/Bootcamps/BootcampsHomeScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseScreen.dart';
import 'package:bootcamps/Pages/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List _screen = [
    BootcampsScreen(),
    CourseScreen(),
    DetailHomeScreen(),
    Container(
      color: Colors.green,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: AppTheme.bg,
        containerHeight: 55,
        selectedIndex: _currentIndex,
        itemCornerRadius: 25,
        curve: Curves.decelerate,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          bottomNavyBarItem(
              text: "HOme", icon: Icon(Icons.home_filled), context: context),
          bottomNavyBarItem(
              text: "Explore", icon: Icon(Icons.explore), context: context),
          bottomNavyBarItem(
              text: "Search", icon: LineIcon.search(), context: context),
          bottomNavyBarItem(
              text: "HOme", icon: Icon(Icons.dehaze), context: context),
        ],
      ),
    );
  }
}

BottomNavyBarItem bottomNavyBarItem({text, context, icon}) {
  return BottomNavyBarItem(
    icon: icon,
    activeColor: AppTheme.green,
    inactiveColor: AppTheme.green,
    title: Text(
      text,
      style: Theme.of(context).textTheme.button,
    ),
    textAlign: TextAlign.center,
  );
}

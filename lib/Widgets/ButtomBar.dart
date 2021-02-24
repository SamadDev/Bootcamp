import 'package:bootcamps/Pages/Bootcamps/BootcampsScreen.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List _screen = [
    BootcampsScreen(),
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.red,
    ),
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
          BottomNavyBarItem(
            activeColor: AppTheme.green,
            inactiveColor: AppTheme.green,
            icon: Icon(Icons.home),
            title: Text('Home'),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: LineIcon.swatchbook(),
            activeColor: AppTheme.green,
            inactiveColor: AppTheme.green,
            title: Text('courses'),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            activeColor: AppTheme.green,
            inactiveColor: AppTheme.green,
            icon: Icon(Icons.home_outlined),
            title: Text('Users'),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            activeColor: AppTheme.green,
            inactiveColor: AppTheme.green,
            icon: Icon(Icons.message),
            title: Text(
              'Message',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

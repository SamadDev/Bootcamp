import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Bootcamps/HomeScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseSearch.dart';
import 'package:bootcamps/Pages/Courses/love.dart';
import 'package:bootcamps/Pages/Enroll/EnrollScree.dart';
import 'package:bootcamps/Pages/Enroll/EnrollmessageScreen.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Providers/enrollment.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List _screen = [
    BootcampsScreen(),
    LoveScreen(),
    Profile.userRole == 'publisher' ? EnrollMenScreen() : EnrollMessageScreen(),
    MainDrawer(),
  ];

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context);
    getData() {
      Provider.of<Profile>(context, listen: false).getUser(context);
      Provider.of<Enroll>(context, listen: false).fitchEnroll(context: context);
    }

    return ConnectivityWidget(
        showOfflineBanner: false,
        builder: (ctx, isOnline) => isOnline
            ? Scaffold(
                body: FutureBuilder(
                  future: getData(),
                  builder: (ctx, snap) =>
                      snap.connectionState == ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : _screen[_currentIndex],
                ),
                bottomNavigationBar: BottomNavyBar(
                  backgroundColor: Theme.of(context).cardColor,
                  containerHeight: 60,
                  selectedIndex: _currentIndex,
                  itemCornerRadius: 20,
                  curve: Curves.decelerate,
                  onItemSelected: (index) =>
                      setState(() => _currentIndex = index),
                  items: <BottomNavyBarItem>[
                    bottomNavyBarItem(
                        text: language.words['home'],
                        icon: Image.asset(
                          "assets/images/home.png",
                          width: 23,
                          height: 23,
                        ),
                        context: context),
                    bottomNavyBarItem(
                        text: language.words['search1'],
                        icon: Image.asset(
                          'assets/images/heart.png',
                          width: 23,
                          height: 23,
                        ),
                        context: context),
                    bottomNavyBarItem(
                        text: language.words['notification'],
                        icon: Image.asset(
                          "assets/images/bell1.png",
                          width: 23,
                          height: 23,
                        ),
                        context: context),
                    bottomNavyBarItem(
                        text: language.words['more'],
                        icon: Image.asset(
                          "assets/images/menu.png",
                          width: 23,
                          height: 23,
                        ),
                        context: context),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: AppTheme.white,
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/wifi.gif',
                        width: 400,
                        height: 400,
                        fit: BoxFit.fill,
                      ),
                      FlatButton(
                        child: Text(
                          "retry",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: AppTheme.white),
                        ),
                        color: AppTheme.green,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ));
  }
}

BottomNavyBarItem bottomNavyBarItem({text, context, icon}) {
  return BottomNavyBarItem(
    icon: icon,
    activeColor: AppTheme.green,
    inactiveColor: AppTheme.black1,
    title: Text(
      text,
      style: Theme.of(context).textTheme.bodyText1,
    ),
    textAlign: TextAlign.center,
  );
}

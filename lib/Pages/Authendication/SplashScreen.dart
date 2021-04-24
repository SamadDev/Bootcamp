import 'dart:async';

import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    getUser();
    startTime();
  }

  void getUser() async {
    await Provider.of<Profile>(context, listen: false).getUser(context);
  }

  startTime() {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 300,
                width: 300,
                child: Image.asset('assets/images/skillup.png')),
            Padding(padding: EdgeInsets.only(top: 70.0)),
            circleProgress()
          ],
        ),
      ),
    );
  }
}

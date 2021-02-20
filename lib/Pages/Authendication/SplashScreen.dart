import 'dart:async';
import 'package:provider/provider.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampCoursePopulate.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampsScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseScreen.dart';
import 'package:bootcamps/Pages/ObordScreen/GettingStartedScreen.dart';
import 'package:bootcamps/Providers/SignUp.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
//Ⓢⓚⓘⓛⓛ Ⓤⓟ

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  void getUser() async {
    await Provider.of<Profile>(context, listen: false).getUser(context);
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Auth.token != null
                ? GettingStartedScreen()
                : BootcampsScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/splash.gif"),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            // Text(
            //   "🆂🅺🅸🅻🅻 🆄🅿",
            //   style: TextStyle(fontSize: 20.0),
            // ),
            // Padding(padding: EdgeInsets.only(top: 20.0)),
            // CircularProgressIndicator(
            //   backgroundColor: Colors.amberAccent,
            //   strokeWidth: 1,
            // )
          ],
        ),
      ),
    );
  }
}

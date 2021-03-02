import 'dart:async';

import 'package:bootcamps/Pages/ObordScreen/GettingStartedScreen.dart';
import 'package:bootcamps/Providers/SignUp.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            Auth.token != null ? GettingStartedScreen() : HomeScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset('assets/images/e.svg')),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: AppTheme.orange,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}

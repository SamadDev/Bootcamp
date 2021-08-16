import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  static const String route = "/NotFoundScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/box.png',
        color: Theme.of(context).buttonColor,
        height: 120,
        width: 120,
      )),
    );
  }
}

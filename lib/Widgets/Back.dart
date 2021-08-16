import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Back extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => HomeScreen()),
              (route) => false);
        },
        icon: Icon(Icons.arrow_back_ios_sharp));
  }
}

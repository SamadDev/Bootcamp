import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  static const String route = "/NotFoundScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Image.asset('assets/images/emptygif.gif'),
    );
  }
}

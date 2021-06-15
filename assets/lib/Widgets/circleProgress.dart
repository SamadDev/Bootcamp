import 'package:bootcamps/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circleProgress() {
  return CircularProgressIndicator(
    valueColor: new AlwaysStoppedAnimation<Color>(AppTheme.black2),
    strokeWidth: 4,
    backgroundColor: AppTheme.green,
  );
}

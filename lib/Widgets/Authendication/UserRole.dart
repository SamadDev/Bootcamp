import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

Widget roleType({context, text}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 60,
      padding: EdgeInsets.only(top: 6, left: 20, right: 10, bottom: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppTheme.black2,
          boxShadow: [BoxShadow(color: AppTheme.black3, blurRadius: 1)]),
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          enabled: false,
          hintStyle: Theme.of(context).textTheme.headline4,
          border: InputBorder.none,
          icon: Icon(
            Icons.people,
            size: 20,
            color: AppTheme.black1,
          ),
          hintText: text,
        ),
      ),
    ),
  );
}

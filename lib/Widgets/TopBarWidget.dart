import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Search.dart';
import 'package:flutter/material.dart';

Widget topBarWidget({context, name, function, icon}) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchField(),
        GestureDetector(
          onTap: function,
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppTheme.black2,
                  borderRadius: BorderRadius.circular(60)),
              child: icon),
        )
      ],
    ),
  );
}

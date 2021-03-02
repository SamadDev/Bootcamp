import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

Widget topBarWidget({context, name, function}) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headline2,
        ),
        GestureDetector(
          onTap: function,
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppTheme.black2,
                  borderRadius: BorderRadius.circular(60)),
              child: LineIcon.search(
                size: 30,
                color: AppTheme.black1,
              )),
        )
      ],
    ),
  );
}

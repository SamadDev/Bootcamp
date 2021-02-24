import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampOfferScreen.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

import '../Bootcamps/BootcampCoursePopulate.dart';
import '../Bootcamps/CategoryList.dart';

class BootcampsScreen extends StatelessWidget {
  static const route = "/BootcampsScreen";

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context).words;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, left: 20, right: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: AppTheme.black2,
                          borderRadius: BorderRadius.circular(60)),
                      child: LineIcon.search(
                        size: 30,
                        color: AppTheme.black1,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 210,
                child: BootcampOfferScreen(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 10, bottom: 10),
              child: Container(
                height: 100,
                child: CategoryList(),
              ),
            ),
            captionPadding(
                context: context, caption: 'Most Populate', function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 15, left: 15),
              child: Container(
                height: 200,
                child: BootcampCoursePopulate(
                  filter: 'averageView',
                ),
              ),
            ),
            captionPadding(
                context: context, caption: 'Recent Course', function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 15, left: 15),
              child: Container(
                height: 200,
                child: BootcampCoursePopulate(
                  filter: 'createdAt',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget captionPadding({context, caption, function}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          caption,
          style: Theme.of(context).textTheme.headline3,
        ),
        GestureDetector(
          onTap: function,
          child: Text(
            'See All',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    ),
  );
}

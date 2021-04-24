import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Bootcamps/CourseOferScreen.dart';
import 'package:bootcamps/Pages/Bootcamps/CoursessVertical.dart';
import 'package:bootcamps/Pages/Courses/CourseFilter/CourseFilterScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseSearch.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/TopBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

import '../Bootcamps/CoursePopulate.dart';
import '../Category/CategoryList.dart';

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
            topBarWidget(
                context: context,
                name: 'Home',
                icon: Icon(Icons.tune),
                function: () {
                  Navigator.of(context).pushNamed(CourseFilterScreen.route);
                }),
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 200,
                        child: BootcampOfferScreen(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, top: 10, bottom: 10),
                      child: Container(
                        height: 100,
                        child: CategoryList(),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 180,
                    left: 15,
                    child: Container(
                      height: 75,
                      width: 320,
                      child: _searchWidget(context),
                    ))
              ],
            ),
            captionPadding(
                context: context, caption: 'Most Populate', function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 15, left: 15),
              child: Container(
                height: 240,
                child: BootcampCoursePopulate(),
              ),
            ),
            captionPadding(
                context: context, caption: 'Recent Course', function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 15, left: 15),
              child: Container(
                height: 240,
                child: BootcampCoursePopulate(),
              ),
            ),
            captionPadding(
                context: context, caption: 'Courses', function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
              child: BootcampCourses(),
            )
          ],
        ),
      ),
    );
  }
}

Widget captionPadding({context, caption, function}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          caption,
          style: Theme
              .of(context)
              .textTheme
              .headline3,
        ),
        GestureDetector(
          onTap: function,
          child: Text(
            'See All',
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ),
      ],
    ),
  );
}

Widget _searchWidget(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed(CourseSearch.route);
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppTheme.black2,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        child: TextField(
          enabled: false,
          style: Theme
              .of(context)
              .textTheme
              .bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: RotatedBox(
                quarterTurns: 3,
                child: LineIcon.search(
                  size: 35,
                  color: AppTheme.black4,
                ),
              ),
              hintText: 'Search to ..',
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .headline6),
        ),
      ),
    ),
  );
}

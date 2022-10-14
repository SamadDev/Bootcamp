import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Bootcamps/CourseOferScreen.dart';
import 'package:bootcamps/Pages/Bootcamps/CourseRecent.dart';
import 'package:bootcamps/Pages/Bootcamps/CoursessVertical.dart';
import 'package:bootcamps/Pages/Courses/CourseFilter/CourseFilterScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseSearch.dart';
import 'package:bootcamps/Pages/Enroll/EnrollScree.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Providers/profile.dart';
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
    final language = Provider.of<Language>(context);
    return Scaffold(
floatingActionButton: FloatingActionButton(onPressed: (){
  Provider.of<Enroll>(context,listen:false).enrollFilter(Profile.userId);
},),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topBarWidget(
                context: context,
                name: language.words['top'],
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 13, left: 15, top: 10, bottom: 20),
                      child: Container(
                        height: 100,
                        child: CategoryList(),
                      ),
                    ),
                  ],
                ),
                // Positioned(
                //     top: 180,
                //     left: 18,
                //     child: Container(
                //       height: height * 0.105,
                //       width: width * 0.9,
                //       child: searchWidget(context),
                //     ))
              ],
            ),
            captionPadding(
                context: context, caption: language.words['populate'], function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, right: 15, left: 15),
              child: Container(
                height: 240,
                child: BootcampCoursePopulate(),
              ),
            ),
            captionPadding(
                context: context, caption: language.words['recent'], function: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 15, left: 15),
              child: Container(
                height: 240,
                child: CourseRecent(),
              ),
            ),
            captionPadding(
                context: context, caption: language.words['courses'], function: () {}),
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
  final language = Provider.of<Language>(context);
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          caption,
          style: Theme.of(context).textTheme.headline4,
        ),
        GestureDetector(
          onTap: function,
          child: Text(
            language.words['seeAll'],
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    ),
  );
}

Widget searchWidget(context) {
  final language = Provider.of<Language>(context);
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
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: RotatedBox(
                quarterTurns: 3,
                child: LineIcon.search(
                  size: 35,
                  color: AppTheme.black4,
                ),
              ),
              hintText: language.words['search'],
              hintStyle: Theme.of(context).textTheme.headline6),
        ),
      ),
    ),
  );
}

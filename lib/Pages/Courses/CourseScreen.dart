import 'package:bootcamps/Pages/Bootcamps/CoursessVertical.dart';
import 'package:bootcamps/Pages/Bootcamps/DashbordScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseSearch.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/TopBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class CourseScreen extends StatelessWidget {
  static const route = '/CourseScreen';

  final singleSelected;

  CourseScreen({this.singleSelected});

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topBarWidget(
                name: 'Courses',
                icon: LineIcon.search(
                  size: 30,
                  color: AppTheme.black1,
                ),
                function: () {
                  Navigator.of(context).pushNamed(CourseSearch.route);
                },
                context: context),
            SizedBox(
              height: 15,
            ),
            Container(height: 130, child: BootcampScreen()),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 0),
              child: Text(
                'Explore',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 5.0, right: 5),
              child: BootcampCourses(),
            )
          ],
        ),
      ),
    );
  }
}

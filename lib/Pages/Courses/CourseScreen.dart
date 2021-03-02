import 'package:bootcamps/Pages/Bootcamps/BootcamScreen.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampCoursess.dart';
import 'package:bootcamps/Pages/Courses/CourseCategory.dart';
import 'package:bootcamps/Widgets/TopBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            topBarWidget(name: 'Courses', function: () {}, context: context),
            Container(height: 150, child: BootcampScreen()),
            Padding(
              padding:
                  const EdgeInsets.only(top: 25, bottom: 5, right: 5, left: 5),
              child: Container(
                height: 180,
                child: CourseCategory(),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
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

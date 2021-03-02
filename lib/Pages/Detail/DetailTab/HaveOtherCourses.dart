import 'package:bootcamps/Pages/Bootcamps/BootcampCoursess.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherCoursesRelate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<Course>(
      builder: (context, course, _) => ListView.builder(
          itemCount: course.courseList.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: course.courseList[i], child: BootcampCourseWidget())),
    ));
  }
}

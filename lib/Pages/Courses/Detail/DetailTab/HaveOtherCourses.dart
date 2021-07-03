import 'package:bootcamps/Pages/Bootcamps/CoursessVertical.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherCoursesRelate extends StatefulWidget {
 final id;
 OtherCoursesRelate({this.id});
  _OtherCoursesRelateState createState() => _OtherCoursesRelateState();
}

class _OtherCoursesRelateState extends State<OtherCoursesRelate> {
  initState() {
    super.initState();
    getUserCourse();
  }

  getUserCourse() {
    Provider.of<Course>(context, listen: false)
        .courseWithUserId(widget.id);
  }

  Widget build(BuildContext context) {
    return Container(
        child: Consumer<Course>(
      builder: (context, course, _) => ListView.builder(
          itemCount: course.userCourse.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: course.userCourse[i],
              child: BootcampCourseWidget(
                data: course.userCourse[i],
              ))),
    ));
  }
}

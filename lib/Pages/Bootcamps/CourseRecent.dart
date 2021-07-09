import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Widgets/Courses/MostFilterWidget.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CourseRecent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: FutureBuilder(
          future:
          Provider.of<Course>(context, listen: false).mostRecent('createdAt'),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: circleProgress());
            } else
              return Consumer<Course>(
                  builder: (context, course, _) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: course.recentList
                          .map<Widget>((e) => MostFilterWidget(
                        data: e,
                      ))
                          .toList(),
                    ),
                  ));
          }),
    );
  }
}
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Courses/MostFilterWidget.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCoursesScreen extends StatelessWidget {

  final filter;
  AllCoursesScreen({this.filter});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1,),
      body: FutureBuilder(
          future: Provider.of<Course>(context, listen: false)
              .mostPopulate(filter),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: circleProgress());
            } else
              return Consumer<Course>(
                  builder: (context, course, _) => GridView.builder(
                      itemCount: course.courseList.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.72,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (ctx, i) =>  MostFilterWidget(
                        data: course.mosPopulateList[i],
                      )
                  ));
          }),
    );
  }
}

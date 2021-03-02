import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BootcampCourses extends StatelessWidget {
  static const route = '/CourseScreen';

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Course>(context, listen: false)
            .fitchAllCourse('createdAt'),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: AppTheme.orange,
                strokeWidth: 1,
              ),
            );
          } else {
            return Consumer<Course>(
                builder: (ctx, course, _) => SingleChildScrollView(
                      child: Column(
                        children: course.courseList
                            .map<Widget>((e) => ChangeNotifierProvider.value(
                                  child: BootcampCourseWidget(),
                                  value: e,
                                ))
                            .toList(),
                      ),
                    ));
          }
        });
  }
}

class BootcampCourseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CourseData>(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  data.photo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Complete 2021 Flutter\nDevelopment Bootcamp with Dart',
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    ),
                    Text(
                      "${data.tuition.toString()} \$",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    ),
                    Row(
                      children: [
                        Text(
                          '1.2 K',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline6,
                        ),
                        Icon(
                          Icons.visibility,
                          color: AppTheme.black4,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "5",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline6,
                        ),
                        Icon(
                          Icons.star,
                          color: AppTheme.black4,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

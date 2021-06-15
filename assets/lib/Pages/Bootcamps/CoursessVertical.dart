import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BootcampCourses extends StatelessWidget {
  static const route = '/CourseScreen';

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Course>(context, listen: false).fitchAllCourse(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: circleProgress());
          } else {
            return Consumer<Course>(
                builder: (ctx, course, _) => SingleChildScrollView(
                      child: Column(
                        children: course.courseList
                            .map<Widget>((e) => BootcampCourseWidget(
                                  data: e,
                                ))
                            .toList(),
                      ),
                    ));
          }
        });
  }
}

class BootcampCourseWidget extends StatelessWidget {
  final CourseData data;

  BootcampCourseWidget({this.data});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => DetailHomeScreen(id: data.id)));
        },
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
                  child: CachedNetworkImage(
                    imageUrl: data.photo,
                    fit: BoxFit.fill,
                    placeholder: (ctx, snap) => Center(
                      child: CircularProgressIndicator(),
                    ),
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
                        data.title,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        "${data.tuition.toString()} \$",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Row(
                        children: [
                          Text(
                            data.view == null ? "0" : "${data.view}",
                            style: Theme.of(context).textTheme.headline6,
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
                            data.averageRating == null
                                ? "0"
                                : "${data.averageRating.toStringAsFixed(1)}",
                            style: Theme.of(context).textTheme.headline6,
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
      ),
    );
  }
}

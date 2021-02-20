import 'package:bootcamps/Pages/Courses/CourseDetailScreen.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootcampDetailScreen extends StatelessWidget {
  static const route = "/BootcampDetailScreen";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final bootcampId = ModalRoute.of(context).settings.arguments as String;
    final data =
        Provider.of<BootCamp>(context, listen: false).findById(bootcampId);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          data.name,
          maxLines: 1,
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: height / 3.5,
                width: width,
                child: Image.network(
                  data.photo,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 5),
              child: Text(
                data.name,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff072b09)),
              ),
            ),
            courseInfoText(data.description),
            topTextOfCourseDetailScreen('Careers'),
            courseInfoText(data.careers),
            topTextOfCourseDetailScreen('Information'),
            courseInfoText('average cost: ${data.averageCost.toString()}'),
            courseInfoText("address: ${data.address}"),
            topTextOfCourseDetailScreen('Courses'),
            Container(
              height: 300,
              width: width,
              child: CourseDetailWidget(
                bootcampId: data.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetailWidget extends StatelessWidget {
  final bootcampId;

  CourseDetailWidget({this.bootcampId});

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Course>(context, listen: false)
            .fitchCoursesRefBootcamp(bootcampId),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<Course>(
                builder: (ctx, course, _) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: course.bootcampCourse.length,
                    itemBuilder: (cxt, index) => Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      CourseDetailScreen.route,
                                      arguments:
                                          course.bootcampCourse[index].id);
                                },
                                child: Padding(
                                  padding: (EdgeInsets.all(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 270,
                                          height: 200,
                                          child: CachedNetworkImage(
                                            imageUrl: course
                                                .bootcampCourse[index].photo,
                                            fit: BoxFit.fill,
                                            placeholder: (_, index) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )),
                                      courseText(
                                          'title: ${course.bootcampCourse[index].title} '),
                                      courseText(
                                          'tuition: ${course.bootcampCourse[index].tuition} \$'),
                                      courseText(
                                          'minim skills: ${course.bootcampCourse[index].minimumSkill}'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )));
          }
        });
  }
}

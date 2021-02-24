import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootcampCoursePopulate extends StatelessWidget {
  // List states = [
  //   {"title": "most popular", 'value': 'averageView'},
  //   {"title": "recent courses", 'value': 'createdAt'},
  //   {"title": "highest rating", 'value': 'averageRating'},
  // ];
  // String state = 'averageView';
  // bool isClick = false;
  //
  // void changeClick() {
  //   setState(() {
  //     isClick = !isClick;
  //   });
  // }

  //                  DropdownButton(
  //                       underline: SizedBox.shrink(),
  //                       value: state,
  //                       items: states
  //                           .map((e) => DropdownMenuItem(
  //                                 child: Text(e['title']),
  //                                 value: e['value'],
  //                               ))
  //                           .toList(),
  //                       onChanged: (value) {
  //                         setState(() {
  //                           state = value;
  //                         });
  //                       })
  final filter;

  BootcampCoursePopulate({this.filter});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: FutureBuilder(
          future: Provider.of<Course>(context, listen: false)
              .fitchAllCourse(filter),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppTheme.orange,
                  strokeWidth: 1,
                ),
              );
            } else
              return Consumer<Course>(
                  builder: (context, course, _) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: course.courseList
                          .map<Widget>((e) => ChangeNotifierProvider.value(
                        child: CourseWidget(),
                        value: e,
                      ))
                          .toList(),
                    ),
                  ));
          }),
    );
  }
}

class CourseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CourseData>(context, listen: false);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.black2,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          width: 170,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: data.photo,
                      fit: BoxFit.fill,
                      placeholder: (ctx, snap) => Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppTheme.orange,
                          strokeWidth: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    data.title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        labelStyle: Theme.of(context).textTheme.subtitle1,
                        labelPadding: EdgeInsets.zero,
                        backgroundColor: AppTheme.black2.withOpacity(0.4),
                        label: Text(
                          '\$ ${data.tuition.toString()}',
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      Chip(
                        labelStyle: Theme.of(context).textTheme.subtitle1,
                        labelPadding: EdgeInsets.zero,
                        backgroundColor: AppTheme.black2.withOpacity(0.4),
                        label: Row(
                          children: [
                            Text(
                              '5',
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Icon(
                                Icons.star,
                                color: AppTheme.green,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

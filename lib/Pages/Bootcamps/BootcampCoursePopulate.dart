import 'package:bootcamps/Providers/Course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootcampCoursePopulate extends StatefulWidget {
  @override
  _BootcampCoursePopulateState createState() => _BootcampCoursePopulateState();
}

class _BootcampCoursePopulateState extends State<BootcampCoursePopulate> {
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

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: FutureBuilder(
          future: Provider.of<Course>(context, listen: false)
              .fitchAllCourse('averageView'),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
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
      splashColor: Colors.transparent,
      onTap: () {},
      child: SizedBox(
        width: 280,
        child: Stack(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 48 + 24.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFe8e8e8),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48 + 24.0,
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        'Website development',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('${5} weeks',
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  '${5}',
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, right: 16),
                                      child: Text(
                                        '\$${data.tuition}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: AspectRatio(
                          aspectRatio: 3.3 / 3,
                          child: Image.network(
                            data.photo,
                            fit: BoxFit.fill,
                          )),
                    )
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

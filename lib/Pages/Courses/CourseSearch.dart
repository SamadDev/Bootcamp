import 'package:bootcamps/Pages/Bootcamps/CoursePopulate.dart';
import 'package:bootcamps/Pages/Courses/CourseFilter/CourseFilterScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class CourseSearch extends StatelessWidget {
  static const route = "/CourseSearch";

  @override
  Widget build(BuildContext context) {
    final course = Provider.of<Course>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: AppTheme.black2,
                        borderRadius: BorderRadius.circular(60)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CourseFilterScreen.route);
                      },
                      child: Icon(
                        Icons.tune,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SearchWidget(),
            Expanded(
              child: FutureBuilder(
                  future: course.fitchAllCourse(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(child: circleProgress());
                    } else
                      return Consumer<Course>(
                          builder: (context, course, _) => GridView.builder(
                              itemCount: course.search.isEmpty
                                  ? course.courseList.length
                                  : course.search.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5),
                              itemBuilder: (ctx, i) => course.search.isEmpty
                                  ? CourseWidget(
                                      data: course.courseList[i],
                                    )
                                  : CourseWidget(
                                      data: course.search[i],
                                    )));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Widget build(BuildContext context) {
    final course = Provider.of<Course>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppTheme.black2,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            setState(() {
              course.searchCourse(value);
            });
          },
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: LineIcon.search(
                size: 30,
                color: AppTheme.black4,
              ),
              hintText: 'Search to ..',
              hintStyle: Theme.of(context).textTheme.headline6),
        ),
      ),
    );
  }
}

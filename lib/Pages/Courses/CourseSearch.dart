import 'package:bootcamps/Pages/Bootcamps/BootcampCoursePopulate.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class CourseSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: AppTheme.black2,
                      borderRadius: BorderRadius.circular(60)),
                  child: Icon(
                    Icons.filter_list,
                    size: 25,
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: AppTheme.black2,
                      borderRadius: BorderRadius.circular(60)),
                  child: Icon(
                    Icons.tune,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppTheme.black2,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              child: TextField(
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
          ),
          Expanded(
            child: FutureBuilder(
                future: Provider.of<Course>(context, listen: false)
                    .fitchAllCourse('createAt'),
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
                        builder: (context, course, _) => GridView.builder(
                            itemCount: course.courseList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                                    value: course.courseList[i],
                                    child: CourseWidget())));
                }),
          )
        ],
      ),
    );
  }
}

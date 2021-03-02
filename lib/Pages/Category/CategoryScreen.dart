import 'package:bootcamps/Pages/Bootcamps/BootcampCoursePopulate.dart';
import 'package:bootcamps/Providers/BootcampCategory.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Widget build(BuildContext context) {
    var _value = 0;

    final categoryList = Provider.of<Category>(context).categoryList;
    List _tabs = categoryList
        .map<Widget>((e) => Tab(
              child: Text(e.type),
            ))
        .toList();
    return DefaultTabController(
      length: categoryList.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: Container(
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
            )
          ],
          elevation: 0,
          bottom: TabBar(
            onTap: (value) {
              print(value);
              setState(() {
                _value = value;
              });
              print(_value);
            },
            indicatorColor: AppTheme.green,
            unselectedLabelColor: AppTheme.black1.withOpacity(0.5),
            labelColor: AppTheme.green,
            unselectedLabelStyle: Theme.of(context).textTheme.headline5,
            labelStyle: Theme.of(context).textTheme.headline5,
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
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
                      prefixIcon: RotatedBox(
                        quarterTurns: 3,
                        child: LineIcon.search(
                          size: 35,
                          color: AppTheme.black4,
                        ),
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
      ),
    );
  }
}

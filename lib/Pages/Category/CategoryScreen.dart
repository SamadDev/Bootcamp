import 'package:bootcamps/Pages/Bootcamps/CoursePopulate.dart';
import 'package:bootcamps/Pages/Courses/CourseFilter/CourseFilterScreen.dart';
import 'package:bootcamps/Providers/Category.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final id;
  final title;

  CategoryScreen({this.title, this.id});

  static const route = "/CategoryScreen";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Widget build(BuildContext context) {
    final course = Provider.of<Course>(context, listen: false);
    final category = Provider.of<Category>(context, listen: false);
    final technology = course.findCategory("Technology");
    final business = course.findCategory("Business");
    final language = course.findCategory("Language");
    final sport = course.findCategory("Sport");
    final art = course.findCategory("Art");
    final fitness = course.findCategory("Fitness");

    final categoryList = category.categoryList;
    List _tabs = categoryList
        .map<Widget>((e) => Tab(
              child: Text(e['title']),
            ))
        .toList();

    return DefaultTabController(
      initialIndex: int.parse(widget.id),
      length: categoryList.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(CourseFilterScreen.route);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: Container(
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
              ),
            )
          ],
          elevation: 0,
          bottom: TabBar(
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
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<Course>(context, listen: false)
                      .fitchAllCourse(),
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
                          builder: (ctx, course, _) => TabBarView(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        child: searchWidget(
                                            context: context,
                                            onChanged: (value) {
                                              course.cateSearchCourse(
                                                  value, technology);
                                            }),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 800,
                                          child: GridView.builder(
                                              itemCount: course
                                                      .cateSearch.isEmpty
                                                  ? technology.length
                                                  : course.cateSearch.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (ctx, i) =>
                                                  course.cateSearch.isEmpty
                                                      ? CourseWidget(
                                                          data: technology[i],
                                                        )
                                                      : CourseWidget(
                                                          data: course
                                                              .cateSearch[i],
                                                        )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //______________________________

                                  Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        child: searchWidget(
                                            context: context,
                                            onChanged: (value) {
                                              course.cateSearchCourse(
                                                  value, business);
                                            }),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 800,
                                          child: GridView.builder(
                                              itemCount: course
                                                      .cateSearch.isEmpty
                                                  ? business.length
                                                  : course.cateSearch.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (ctx, i) =>
                                                  course.cateSearch.isEmpty
                                                      ? CourseWidget(
                                                          data: business[i],
                                                        )
                                                      : CourseWidget(
                                                          data: course
                                                              .cateSearch[i],
                                                        )),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        child: searchWidget(
                                            context: context,
                                            onChanged: (value) {
                                              course.cateSearchCourse(
                                                  value, language);
                                            }),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 800,
                                          child: GridView.builder(
                                              itemCount: course
                                                      .cateSearch.isEmpty
                                                  ? language.length
                                                  : course.cateSearch.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (ctx, i) =>
                                                  course.cateSearch.isEmpty
                                                      ? CourseWidget(
                                                          data: language[i],
                                                        )
                                                      : CourseWidget(
                                                          data: course
                                                              .cateSearch[i],
                                                        )),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //______________________________

                                  Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        child: searchWidget(
                                            context: context,
                                            onChanged: (value) {
                                              course.cateSearchCourse(
                                                  value, sport);
                                            }),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 800,
                                          child: GridView.builder(
                                              itemCount: course
                                                      .cateSearch.isEmpty
                                                  ? sport.length
                                                  : course.cateSearch.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (ctx, i) =>
                                                  course.cateSearch.isEmpty
                                                      ? CourseWidget(
                                                          data: sport[i],
                                                        )
                                                      : CourseWidget(
                                                          data: course
                                                              .cateSearch[i],
                                                        )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //--------------
                                  Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        child: searchWidget(
                                            context: context,
                                            onChanged: (value) {
                                              course.cateSearchCourse(
                                                  value, art);
                                            }),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 800,
                                          child: GridView.builder(
                                              itemCount: course
                                                      .cateSearch.isEmpty
                                                  ? art.length
                                                  : course.cateSearch.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (ctx, i) =>
                                                  course.cateSearch.isEmpty
                                                      ? CourseWidget(
                                                          data: art[i],
                                                        )
                                                      : CourseWidget(
                                                          data: course
                                                              .cateSearch[i],
                                                        )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //______________________________

                                  Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        child: searchWidget(
                                            context: context,
                                            onChanged: (value) {
                                              course.cateSearchCourse(
                                                  value, fitness);
                                            }),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 800,
                                          child: GridView.builder(
                                              itemCount: course
                                                      .cateSearch.isEmpty
                                                  ? fitness.length
                                                  : course.cateSearch.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (ctx, i) =>
                                                  course.cateSearch.isEmpty
                                                      ? CourseWidget(
                                                          data: fitness[i],
                                                        )
                                                      : CourseWidget(
                                                          data: course
                                                              .cateSearch[i],
                                                        )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Widget searchWidget({context, onChanged}) {
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
        onChanged: onChanged,
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
  );
}

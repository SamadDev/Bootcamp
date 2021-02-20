import 'package:bootcamps/Pages/Bootcamps/BootcampCoursePopulate.dart';
import '../Courses/CourseDetailScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatelessWidget {
  static const route = '/CourseScreen';

  final singleSelected;

  CourseScreen({this.singleSelected});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses',
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 150, child: BootcampCoursePopulate()),
              Container(
                child: FutureBuilder(
                    future: Provider.of<Course>(context, listen: false)
                        .fitchAllCourse('createdAt'),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Consumer<Course>(
                            builder: (ctx, course, _) => SingleChildScrollView(
                                  child: Column(
                                    children: course.courseList
                                        .map<Widget>(
                                            (e) => ChangeNotifierProvider.value(
                                                  child: CoffeeItemVertical(),
                                                  value: e,
                                                ))
                                        .toList(),
                                  ),
                                ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoffeeItemVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CourseData>(context);
    return Container(
      height: 140,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                children: [
                  AspectRatio(
                      aspectRatio: 1.2 / 1,
                      child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          clipBehavior: Clip.antiAlias,
                          color: AppTheme.secondaryBg2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: data.photo,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ))),
                  Expanded(
                    flex: 100,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Text(
                              data.title,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: AppTheme.subTitleTextColor),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                data.averageRating != null
                                    ? RatingBarIndicator(
                                        rating: data.averageRating.toDboule(),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      )
                                    : SizedBox.shrink(),
                                Text(data.averageRating == null
                                    ? 'Not rating yet'
                                    : "(${data.averageRating.toString()})")
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              'Tuition: ${data.tuition}\$',
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              'duration: ${data.weeks} weeks ',
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashFactory: InkRipple.splashFactory,
                  splashColor: Colors.black12,
                  onTap: () => Navigator.of(context)
                      .pushNamed(CourseDetailScreen.route, arguments: data.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bootcamps/Pages/Reviews/ReviewsScreen.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

import 'HaveOtherCourses.dart';
import 'Info.dart';
import 'catalog.dart';

class DetailTabScree extends StatefulWidget {
  final videos;
  final videoPath;
  final courseId;

  DetailTabScree({this.videos, this.videoPath, this.courseId});

  _DetailTabScreeState createState() => _DetailTabScreeState();
}

class _DetailTabScreeState extends State<DetailTabScree> {
  List _tab = <Tab>[
    Tab(
      child: Text(
        'Info',
      ),
    ),
    Tab(
      child: Text(
        'Catalog',
      ),
    ),
    Tab(
      child: Text(
        'Reviews',
      ),
    ),
    Tab(
      child: Text('Have Other'),
    )
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tab.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: AppTheme.black2,
            elevation: 0,
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppTheme.green, width: 2),
                  insets: EdgeInsets.symmetric(horizontal: 16.0)),
              indicatorColor: AppTheme.green,
              unselectedLabelColor: AppTheme.black1.withOpacity(0.5),
              unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
              isScrollable: true,
              tabs: _tab,
              labelColor: AppTheme.green,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            InfoScree(),
            CatalogScreen(
              videoPath: widget.videoPath,
              videos: widget.videos,
            ),
            ReviewsScreen(courseId: widget.courseId),
            OtherCoursesRelate()
          ],
        ),
      ),
    );
  }
}

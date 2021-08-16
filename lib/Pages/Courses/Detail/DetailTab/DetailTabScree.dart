import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Reviews/ReviewsScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/CourseModule.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HaveOtherCourses.dart';
import 'Info.dart';
import 'catalog.dart';

class DetailTabScree extends StatefulWidget {
  final videos;
  final videoPath;
  final courseId;
  final user;
  final CourseData data;

  DetailTabScree({this.videos, this.videoPath, this.courseId,this.user,this.data});

  _DetailTabScreeState createState() => _DetailTabScreeState();
}

class _DetailTabScreeState extends State<DetailTabScree> {

  List _tab (context){
    final language=Provider.of<Language>(context,listen:false).words;
    return <Tab>[
    Tab(
      child: Text(
       language['info'],
      ),
    ),
    Tab(
      child: Text(
       language['video'],
      ),
    ),
    Tab(
      child: Text(
        language['review']
      )
    ),
    Tab(
      child: Text(language['have other course']),
    )
  ];}

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tab(context).length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppTheme.green, width: 2),
                  insets: EdgeInsets.symmetric(horizontal: 16.0)),
              indicatorColor: AppTheme.green,
              unselectedLabelColor:Theme.of(context).buttonColor.withOpacity(0.5),
              unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
              isScrollable: true,
              tabs: _tab(context),
              labelColor: AppTheme.green,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            InfoScree(data: widget.data,),
            CatalogScreen(
              courseId: widget.courseId,
              videoPath: widget.videoPath,
              videos: widget.videos,
            ),
            ReviewsScreen(courseId: widget.courseId),
            OtherCoursesRelate(id: widget.user,)
          ],
        ),
      ),
    );
  }
}

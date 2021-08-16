import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Courses/Detail/VideoPlayer.dart';
import 'package:bootcamps/Pages/Enroll/ErnollMenPost.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatefulWidget {
  final List videos;
  final List videoPath;
  final courseId;

  CatalogScreen({this.videos, this.videoPath, this.courseId});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  Widget build(BuildContext context) {


    final enroll = Provider.of<Enroll>(context, listen: false);
    enroll.myEnroll(userId: Profile.userId);
    final data = enroll.singleEnroll(courseId: widget.courseId);
    print(data.isVeryfiy);
final language=Provider.of<Language>(context,listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.9,
              child: widget.videos.isEmpty
                  ? Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/search.png',
                            color: Theme.of(context).buttonColor,
                            fit: BoxFit.fill,
                          )),
                    )
                  : ListView.builder(
                      itemCount: widget.videoPath.length,
                      itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              if (i == 0 || data.isVeryfiy == "true") {
                                print('true or 0');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        VideoPlayerScreen(index: widget.videos[i])));
                              } else if (data.isVeryfiy == 'pending') {
                                print('pending');
                                showMyDialog(
                                    context: context,
                                    courseId: widget.courseId,
                                    text: language.words['pending']);
                              } else  {
                                print('false');
                                showMyDialog(
                                  isShowEnrollButton: 'true',
                                    context: context,
                                    courseId: widget.courseId,
                                    text: language.words['false']);
                              }
                            },
                            child: Card(
                              elevation: 0,
                              color:Theme.of(context).cardColor.withOpacity(0.5),
                              child: ListTile(
                                leading: i == 0
                                    ? Icon(Icons.play_circle_filled_sharp,color:Theme.of(context).buttonColor,)
                                    : LineIcon.lock(color:Theme.of(context).buttonColor,),
                                title: Text(
                                  widget.videoPath[i],
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                trailing: Text('_._',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            ),
                          )),
            ),
          ],
        ),
      ),
    );
  }
}

showMyDialog({context, courseId, isShowEnrollButton = false, text}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final language=Provider.of<Language>(context,listen: false);
      return AlertDialog(backgroundColor: Theme.of(context).cardColor,
        title: Text(language.words['error occur'],style: Theme.of(context).textTheme.headline3,),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
             language.words['ok'],
              style: Theme.of(context).textTheme.headline4,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (isShowEnrollButton=='true')
            TextButton(
              child: Text(
                language.words['enroll'],
                style: Theme.of(context).textTheme.headline4,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => EnrollPostScreen(
                          courseId: courseId,
                        )));
              },
            ),
        ],
      );
    },
  );
}

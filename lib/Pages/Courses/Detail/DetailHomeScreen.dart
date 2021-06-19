import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/Follow.dart';
import 'package:bootcamps/Providers/View&like.dart';
import 'package:bootcamps/Pages/Enroll/ErnollMenPost.dart';
import 'package:bootcamps/Providers/love.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DetailTab/DetailTabScree.dart';

class DetailHomeScreen extends StatefulWidget {
  static const route = "/DetailHomeScreen";
  final id;
  final url;

  DetailHomeScreen({this.id,this.url});

  @override
  _DetailHomeScreenState createState() => _DetailHomeScreenState();
}

class _DetailHomeScreenState extends State<DetailHomeScreen> {
  void initState() {
    super.initState();
    getView();
  }

  getView() {
    Provider.of<SLocalStorage>(context, listen: false).fetchLoveList();
    print(Provider.of<SLocalStorage>(context, listen: false).fetchLoveList());
    Provider.of<Follow>(context, listen: false)
        .fitchAllFollows(context: context, userId: Profile.userId);
    Provider.of<View>(context, listen: false)
        .postView(context: context, newView: 1, courseId: widget.id);
  }

  Widget build(BuildContext context) {
    final follow = Provider.of<Follow>(context);
    final data = Provider.of<Course>(context).findCourseById(widget.id);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => EnrollPostScreen(courseId: data.id)));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 280,
                  child: Image.network(
                    data.photo,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: AppTheme.green.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(60)),
                  child: Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 5, left: 15.0, top: 15, bottom: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 10,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          data.title,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Container(height: 45,width: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color: AppTheme.black2),
                        child: Consumer<SLocalStorage>(
                            builder: (ctx, love, _) => GestureDetector(
                                onTap: () async {
                                  if (love.courseList.contains(data.photo)) {
                                   await love.removeCourse(data.photo);
                                  } else {
                                    love.addToLoveList(data.photo);
                                  }
                                },
                                child: love.courseList == null
                                    ? Icon(
                                        Icons.favorite_border,
                                        color: AppTheme.black1,
                                        size: 30,
                                      )
                                    : love.courseList.contains(data.photo)
                                        ? Icon(
                                            Icons.favorite,
                                            color: AppTheme.green,
                                            size: 30,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            color: AppTheme.black1,
                                            size: 30,
                                          ))),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${data.weeks} hours',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        width: 10,
                        child: Center(
                          child: Text(
                            '|',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      Text(
                        '${data.view == null ? 0 : data.view} view',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  Text(
                    '\$${data.tuition}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 10,
              children: [
                Divider(
                  thickness: 2,
                ),
                Container(
                  color: AppTheme.black2,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.zero,
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              'https://pbs.twimg.com/profile_images/1213052345606639616/SWxoF4Rm_400x400.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "samad shukr",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Consumer<Follow>(
                              builder: (ctx, follower, _) => Text(
                                '${follower.followList.length} Followers',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        follow.follow
                            ? Center(child: circleProgress())
                            : GestureDetector(
                                // onTap: () async {
                                //   follow.changeIcon();
                                //   follow.icon
                                //       ? await follow.postFollow(
                                //           context: context,
                                //           userId: Profile.userId,
                                //           newFollow: true)
                                //       : await follow.followList.removeLast();
                                // },
                                child: Container(
                                  height: 30,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppTheme.green),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // follow.icon
                                      //     ? Icon(
                                      //         Icons.check,
                                      //         color: AppTheme.green,
                                      //       )
                                      //     : Icon(
                                      //         Icons.add,
                                      //         size: 15,
                                      //         color: AppTheme.green,
                                      //       ),
                                      Text(
                                        'Profile',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                height: 400,
                child: DetailTabScree(
                  videos: data.videos,
                  videoPath: data.videoPath,
                  courseId: data.id,
                )),
          ],
        ),
      ),
    );
  }
}

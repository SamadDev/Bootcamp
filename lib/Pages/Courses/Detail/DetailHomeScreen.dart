import 'package:bootcamps/Pages/Authendication/ProfilePublisher.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailTab/catalog.dart';
import 'package:bootcamps/Pages/Courses/Detail/VideoPlayer.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/View.dart';
import 'package:bootcamps/Pages/Enroll/ErnollMenPost.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Providers/love.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Back.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'DetailTab/DetailTabScree.dart';
import 'package:bootcamps/Localization/language.dart';

class DetailHomeScreen extends StatefulWidget {
  static const route = "/DetailHomeScreen";
  final id;
  final pending;

  DetailHomeScreen({this.id, this.pending});

  @override
  _DetailHomeScreenState createState() => _DetailHomeScreenState();
}

class _DetailHomeScreenState extends State<DetailHomeScreen> {
  void initState() {
    getData();
    super.initState();
  }

  String isEnroll;

  Future<void> getData() async {
    final enroll = Provider.of<Enroll>(context, listen: false);

    Provider.of<SLocalStorage>(context, listen: false).fetchLoveList();
    // await enroll.fitchEnroll(context: context);
    enroll.myEnroll(userId: Profile.userId);
    widget.pending != null
        ? isEnroll = widget.pending
        : isEnroll = enroll.singleEnroll(courseId: widget.id).isVeryfiy;
    print(isEnroll);
  }

  Future<void> getView() async {
    final view = Provider.of<View>(context, listen: false);
    await view.postView(context: context, newView: 1, courseId: widget.id);
    await view.getViews();
    view.getViewCourseDetail(courseId: widget.id);
  }

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final view = Provider.of<View>(context, listen: false);
    final data = Provider.of<Course>(context).findCourseById(widget.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        VideoPlayerScreen(index: data.videos[0])));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 280,
                    child: CachedNetworkImage(
                      imageUrl: data.photo,
                      fit: BoxFit.fill,
                      placeholder: (ctx, snap) => Container(
                        height: 280,
                        color: AppTheme.green,
                      ),
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
                  language.languageCode == 'en'
                      ? Positioned(
                          top: 30,
                          left: 15,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppTheme.black2,
                                borderRadius: BorderRadius.circular(60)),
                            child: Center(child: Back()),
                          ),
                        )
                      : Positioned(
                          top: 30,
                          right: 15,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppTheme.black2,
                                borderRadius: BorderRadius.circular(60)),
                            child: Center(
                                child:
                                    RotatedBox(quarterTurns: 2, child: Back())),
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10.0, top: 15, bottom: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 10,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          language.languageCode == 'en'
                              ? data.title
                              : language.languageCode == 'ar'
                                  ? data.titleAr
                                  : data.titleKr,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.black2),
                        child: Consumer<SLocalStorage>(
                            builder: (ctx, love, _) => GestureDetector(
                                onTap: () {
                                  print(data.title);
                                  if (love.courseList.contains(data.photo)) {
                                    love.removeCourse(
                                        data.photo, widget.id, data.title,data.titleKr,data.titleAr);
                                  } else {
                                    love.addToLoveList(
                                        data.photo, widget.id, data.title,data.titleKr,data.titleAr);
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
                        '${data.weeks} ${language.words['hours']}',
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
                      FutureBuilder(
                        future: getView(),
                        builder: (ctx, snap) =>
                            snap.connectionState == ConnectionState.waiting
                                ? Shimmer.fromColors(
                                    baseColor: AppTheme.black2,
                                    highlightColor: AppTheme.green,
                                    child: Center(
                                        child: Image.asset(
                                      'assets/images/view.png',
                                      height: 20,
                                      width: 20,
                                    )),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        '${view.viewFilter.isEmpty ? 0 : view.viewFilter.length} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      Image.asset(
                                        'assets/images/view.png',
                                        color: AppTheme.black4,
                                        height: 21,
                                        width: 21,
                                      )
                                    ],
                                  ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${data.tuition}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isEnroll == "true") {
                            showMyDialog(
                                context: context,
                                courseId: widget.id,
                                text: language.words['true']);
                          } else if (isEnroll == 'pending') {
                            showMyDialog(
                                context: context,
                                courseId: widget.id,
                                text: language.words['pending']);
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    EnrollPostScreen(courseId: data.id)));
                          }
                        },
                        child: Container(
                          // margin: EdgeInsets.only(left: 3, right: 3),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppTheme.green),
                          ),
                          child: Center(
                            child: Text(
                              language.words['enroll now'],
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      )
                    ],
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
                  color: Theme.of(context).cardColor,
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
                              child: CachedNetworkImage(
                                imageUrl: data.userPhoto,
                                fit: BoxFit.fill,
                                placeholder: (ctx, snap) => Container(
                                  color: AppTheme.green,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.userName,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ProfileSeller(
                                    id: data.user,
                                    userPhoto: data.userPhoto,
                                    userName: data.userName)));
                          },
                          child: Container(
                            height: 30,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppTheme.green),
                            ),
                            child: Center(
                              child: Text(
                                language.words['profile'],
                                style: Theme.of(context).textTheme.headline5,
                              ),
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
                  data: data,
                  videos: data.videos,
                  videoPath: data.videoPath,
                  courseId: widget.id,
                  user: data.user,
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailTab/catalog.dart';
import 'package:bootcamps/Pages/Reviews/ReviewPostScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Providers/Reviews.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Style/style.dart';

class ReviewsScreen extends StatefulWidget {
  static const route = "/ReviewsScreen";
  final courseId;

  ReviewsScreen({this.courseId});

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String filter;

  String isEnroll;

  Future<void> getData() async {
    final provider = Provider.of<Review>(context, listen: false);
    await provider.fitchReviewsReferCourse(filter: filter);
    provider.getReview(widget.courseId);
    final enroll = Provider.of<Enroll>(context, listen: false);
    await enroll.fitchEnroll(context: context);
    enroll.myEnroll(userId: Profile.userId);
    isEnroll = enroll.singleEnroll(courseId: widget.courseId).isVeryfiy;
  }

  Widget build(BuildContext context) {
    final review = Provider.of<Review>(context, listen: false);
    final language=Provider.of<Language>(context,listen: false).words;

    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    width: 0.2,
                  )),
              child: reviewFilter(
                  context: context,
                  value: filter,
                  onChanged: (value) {
                    setState(() {
                      filter = value;
                    });
                  }),
            ),
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else
                    return review.filterReviewList.isEmpty
                        ? Center(
                            child: Image.asset(
                              'assets/images/search.png',
                              fit: BoxFit.fill,
                              color: Theme.of(context).buttonColor,
                              height: 100,
                              width: 100,
                            ),
                          )
                        : Consumer<Review>(
                            builder: (context, review, _) => ListView.builder(
                                  padding: EdgeInsets.only(bottom: 15),
                                  itemCount: review.filterReviewList.length,
                                  itemBuilder: (ctx, index) => ReviewWidget(
                                    data: review.filterReviewList[index],
                                  ),
                                ));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingWidget(
            txt: language['feedback'],
            leadingIcon: Icons.add,
            onTab: () {
              if (isEnroll == "true") {
                openAlertBox(context, widget.courseId);
              } else if (isEnroll == "pending") {
                showMyDialog(
                    context: context,
                    courseId: widget.courseId,
                    isShowEnrollButton: 'false',
                    text: language['pending']);
              } else {
                showMyDialog(
                    context: context,
                    courseId: widget.courseId,
                    isShowEnrollButton: 'true',
                    text: language['false']);
              }
            }));
  }
}

// openAlertBox(context, widget.courseId);
class ReviewWidget extends StatelessWidget {
  final ReviewData data;

  ReviewWidget({this.data});

  Widget build(BuildContext context) {
    final load = Provider.of<Review>(context);
    return Card(
        color: Theme.of(context).cardColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data.photo != null
                        ? data.photo
                        : 'https://i.ibb.co/mbB2wdY/undraw-profile-pic-ic5t.png'),
                    radius: 25,
                    backgroundColor: AppTheme.green,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, right: 7, left: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.userName}',
                            style: Theme.of(context).textTheme.bodyText1),
                        RatingBarIndicator(
                          rating: data.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: AppTheme.green,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  if (Profile.userId == data.userId)
                    Row(
                      children: [
                        Consumer<Review>(
                          builder: (ctx, review, _) => load.isLoading
                              ? circleProgress()
                              : icon(
                                  color: AppTheme.deleteButton,
                                  context: context,
                                  icon: Icons.delete,
                                  onTap: () {
                                    Provider.of<Review>(context, listen: false)
                                        .deleteReview(reviewId: data.id);
                                  }),
                        ),
                        icon(
                            color: AppTheme.editButton,
                            context: context,
                            icon: Icons.edit_outlined,
                            onTap: () {
                              load.isLoading
                                  ? print('')
                                  : openAlertBox(context, data.id,
                                      reviewId: data.id);
                            }),
                      ],
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.text,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ));
  }
}

Widget isEmptyList() {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 300,
        width: 125,
        child: Center(
          child: SvgPicture.asset('assets/images/empty.svg'),
        ),
      ),
    ),
  );
}

Widget icon({context, onTap, icon, color}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.all(8),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: AppTheme.black4.withOpacity(0.7),
              borderRadius: BorderRadius.circular(60)),
          child: Icon(
            icon,
            color: color,
            size: 20,
          )));
}

List reviewFilterList (context){
  final language=Provider.of<Language>(context,listen: false).words;
  return [
  {"title": language['new'], "value": "-createdAt"},
  {"title": language['old'], "value": "createdAt"},
  {"title": language['height rate'], "value": "-rating"},
  {"title": language['low rate'], "value": "rating"}
];}

Widget reviewFilter({context, value, onChanged}) {
  final language=Provider.of<Language>(context,listen: false).words;
  return DropdownButton(
    icon: Icon(
      Icons.filter_alt,
      color: AppTheme.green,
    ),
    hint: Text(
      language['filter review'],
      style: Theme.of(context).textTheme.bodyText1,
    ),
    elevation: 0,
    dropdownColor: Theme.of(context).cardColor,
    underline: SizedBox.shrink(),
    value: value,
    items: reviewFilterList(context)
        .map((e) => DropdownMenuItem(
              child: Text(e['title'],
                  style: Theme.of(context).textTheme.bodyText1),
              value: e['value'],
            ))
        .toList(),
    onChanged: onChanged,
  );
}

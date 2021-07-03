import 'package:bootcamps/Pages/Reviews/ReviewPostScreen.dart';
import 'package:bootcamps/Providers/Reviews.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Style/style.dart';

class ReviewsScreen extends StatelessWidget {
  static const route = "/ReviewsScreen";
  final courseId;

  ReviewsScreen({this.courseId});

  Widget build(BuildContext context) {
    print(courseId);
    final review = Provider.of<Review>(context, listen: false);

    return Scaffold(
        body: FutureBuilder(
          future: review.fitchReviewsReferCourse(courseId),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else
              return review.reviewList.isEmpty
                  ? Center(
                      child: Image.asset(
                        'assets/images/search.png',
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                      ),
                    )
                  : Consumer<Review>(
                      builder: (context, review, _) => ListView.builder(
                          itemCount: review.reviewList.length,
                          itemBuilder: (ctx, index) =>
                              ChangeNotifierProvider.value(
                                  value: review.reviewList[index],
                                  child: ReviewWidget())));
          },
        ),
        floatingActionButton: FloatingWidget(
          txt: 'Feedback',
          leadingIcon: Icons.add,
          onTab: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ReviewPostScreen(
                      courseId: courseId,
                    )));
          },
        ));
  }
}

class ReviewWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final data = Provider.of<ReviewData>(context);
    return Card(
        color: AppTheme.black2,
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
                        Text(
                          "${data.title} course",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  )
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

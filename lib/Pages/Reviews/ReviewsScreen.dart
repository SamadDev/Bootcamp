import 'package:bootcamps/Pages/Reviews/ReviewPostScreen.dart';
import 'package:bootcamps/Providers/Reviews.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatelessWidget {
  static const route = "/ReviewsScreen";

  Widget build(BuildContext context) {
    final userRole = Profile.userRole;
    final courseId = ModalRoute.of(context).settings.arguments as String;
    final review = Provider.of<Review>(context, listen: false);

    return Scaffold(
        body: Review.count == 0
            ? isEmptyList()
            : FutureBuilder(
                future: review.fitchReviewsReferCourse(courseId),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else
                    return Consumer<Review>(
                        builder: (context, review, _) => ListView.builder(
                            itemCount: review.reviewList.length,
                            itemBuilder: (ctx, index) =>
                                ChangeNotifierProvider.value(
                                    value: review.reviewList[index],
                                    child: ReviewWidget())));
                },
              ),
        floatingActionButton: userRole == 'publisher'
            ? null
            : FloatingWidget(
                txt: 'Feedback',
                leadingIcon: Icons.add,
                onTab: () {
                  Navigator.of(context)
                      .pushNamed(ReviewPostScreen.route, arguments: courseId);
                },
              ));
  }
}

class ReviewWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final data = Provider.of<ReviewData>(context, listen: false);

    return Card(
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
                radius: 35,
                backgroundColor: Colors.teal,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 7, left: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: GoogleFonts.aleo(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    RatingBarIndicator(
                      rating: data.rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
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
        height: 400,
        width: 200,
        child: Center(
          child: SvgPicture.asset('assets/images/empty.svg'),
        ),
      ),
    ),
  );
}

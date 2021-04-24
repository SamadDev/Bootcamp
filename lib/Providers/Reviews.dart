import 'dart:convert';

import 'package:bootcamps/Pages/Reviews/ReviewsScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReviewData with ChangeNotifier {
  final id;
  final title;
  final text;
  double rating;
  final userId;
  final userName;
  final photo;
  final courseId;

  ReviewData(
      {this.courseId,
      this.userId,
      this.photo,
      this.userName,
      this.id,
      this.title,
      this.text,
      this.rating});
}

class Review with ChangeNotifier {
  List<ReviewData> _review = [];

  List<ReviewData> get reviewList => _review;
  static int count = 0;
  String error = '';
  bool isSuccess = false;

  //to get the review refer to the course
  Future<void> fitchReviewsReferCourse(courseId) async {
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId/reviews",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      final jsonData = jsonDecode(res.body)['data'];
      int countReview = jsonDecode(res.body)['count'];
      count = countReview;
      print(countReview);
      final List<ReviewData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          ReviewData(
              title: element['title'],
              text: element['text'],
              rating: element['rating'].toDouble(),
              courseId: element['course'],
              photo: element['user']['photo'],
              userName: element['user']['name']),
        );
      });
      _review = loadCourse;
      notifyListeners();
    } catch (error) {
      print("review get error is $error");
    }
  }

  //to post review to the to the course
  Future<void> postReview(
      {ReviewData newReview, BuildContext context, String courseId}) async {
    try {
      var res = await http.post(
        'https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId/reviews',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({
          'title': newReview.title,
          'text': newReview.text,
          'rating': newReview.rating,
        }),
      );
      final source = jsonDecode(res.body);
      error = source['error'];
      isSuccess = source['success'];

      _review.add(ReviewData(
        title: source['title'],
        text: source['text'],
        rating: source['rating'],
      ));

      if (isSuccess) {
        Navigator.of(context)
            .pushNamed(ReviewsScreen.route, arguments: courseId);
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      showErrorDialog("post review error is $error", context);
    }
    notifyListeners();
  }
}

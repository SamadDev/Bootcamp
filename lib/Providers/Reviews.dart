import 'dart:convert';

import 'package:bootcamps/Pages/Reviews/ReviewsScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  String error = '';
  bool isSuccess = false;

  //to get the review refer to the course
  Future<void> fitchReviewsReferCourse({filter}) async {
    // if (_review.isEmpty)
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/reviews?sort=$filter",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      final jsonData = jsonDecode(res.body)['data'];
      final List<ReviewData> loadReview = [];
      jsonData.forEach((element) {
        loadReview.add(
          ReviewData(
              id: element['_id'],
              title: element['title'],
              text: element['text'],
              rating: element['rating'].toDouble(),
              courseId: element['course'],
              photo: element['user']['photo'],
              userId: element['user']['_id'],
              userName: element['user']['name']),
        );
      });
      _review = loadReview;
      notifyListeners();
    } catch (error) {
      print("review get error is $error");
    }
  }

  List<ReviewData> filterReviewList=[];
  List<void> getReview(courseId){
   return filterReviewList=_review.where((element) => element.courseId==courseId).toList();
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
          'title': 'good',
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

      if (isSuccess != true) {
        showErrorDialog(error, context);
      } else {
        notifyListeners();
        await Provider.of<Review>(context, listen: false)
            .fitchReviewsReferCourse();
        Navigator.of(context).pop();
      }
    } catch (error) {
      showErrorDialog("post review error is $error", context);
    }
  }

  Future<void> updateReview(
      {reviewId, ReviewData review, context, courseId}) async {
    try {
      final index = _review.indexWhere((element) => element.id == reviewId);
      if (index >= 0) {
        final res = await http.put(
            'https://bootcamp-training-training.herokuapp.com/api/v1/reviews/$reviewId',
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${Auth.token}"
            },
            body: json.encode({
              'title': "goode",
              "text": review.text,
              "rating": review.rating.toString()
            }));
        _review[index].rating = review.rating;
        notifyListeners();
      }
    } catch (error) {
      showErrorDialog("post review error is $error", context);
    }
  }

  Future<void> deleteReview({reviewId}) async {
    try {
      changeState();
      await http.delete(
        'https://bootcamp-training-training.herokuapp.com/api/v1/reviews/$reviewId',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
      );
      final index = _review.indexWhere((element) => element.id == reviewId);
      _review.removeAt(index);
      notifyListeners();
      changeState();
    } catch (error) {
      print(error);
    }
  }

  ReviewData findById(reviewId) {
    return _review.firstWhere((element) => element.id == reviewId);
  }

  bool isLoading = false;

  void changeState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}

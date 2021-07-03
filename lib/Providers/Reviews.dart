import 'dart:convert';

import 'package:bootcamps/Pages/Reviews/ReviewsScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// class Data {
//   String sId;
//   String title;
//   String text;
//   double rating;
//   String course;
//   User user;
//   String createdAt;
//   int iV;
//
//   Data(
//       {this.sId,
//         this.title,
//         this.text,
//         this.rating,
//         this.course,
//         this.user,
//         this.createdAt,
//         this.iV});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     text = json['text'];
//     rating = json['rating'];
//     course = json['course'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['text'] = this.text;
//     data['rating'] = this.rating;
//     data['course'] = this.course;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
//
// class User {
//   String sId;
//   String name;
//   String photo;
//
//   User({this.sId, this.name, this.photo});
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     photo = json['photo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['photo'] = this.photo;
//     return data;
//   }
// }


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
  Future<void> fitchReviewsReferCourse(courseId) async {
    // if (_review.isEmpty)
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId/reviews",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      final jsonData = jsonDecode(res.body)['data'];

      final List<ReviewData> loadReview = [];
      jsonData.forEach((element) {
        loadReview.add(
          ReviewData(
              title: element['title'],
              text: element['text'],
              rating: element['rating'].toDouble(),
              courseId: element['course'],
              photo: element['user']['photo'],
              userName: element['user']['name']),
        );
      });
      _review = loadReview;
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

      if (isSuccess != true) {
        showErrorDialog(error, context);
      }
      else {
        notifyListeners();
      await Provider.of<Review>(context,listen: false).fitchReviewsReferCourse(courseId);
        Navigator.of(context).pop();


      }

    } catch (error) {
      showErrorDialog("post review error is $error", context);
    }
  }
}

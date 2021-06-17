import 'dart:convert';

import 'package:bootcamps/Providers/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FollowData with ChangeNotifier {
  final id;
  final userId;
  final follow;

  FollowData({this.userId, this.id, this.follow});
}

class Follow with ChangeNotifier {
  String url = 'https://bootcamp-training-training.herokuapp.com/api/v1';
  List _follow = [];
  bool follow = false;
  bool icon = false;

  List get followList => _follow;
  static int count = 0;
  String error = '';
  bool isSuccess = false;

  Future<void> fitchAllFollows({userId, BuildContext context}) async {
    try {
      var res = await http.get("$url/follow?user=$userId", headers: {
        "Content-Type": "Application/json",
      });

      List jsonData = jsonDecode(res.body)['data'];
      _follow = jsonData;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

// //to post follow to the to the user
  Future<void> postFollow(
      {bool newFollow, BuildContext context, String userId}) async {
    try {
      var res = await http.post(
        '$url/follow/$userId/',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({'follow': newFollow}),
      );
      final source = jsonDecode(res.body);

      isSuccess = source['success'];

      _follow.add(FollowData(
        follow: source['follow'],
      ));
      print(source);
      notifyListeners();
    } catch (error) {
      print(error);
    }

  }

  //delete Course
  Future<void> deleteFollow({BuildContext context,id}) async {
    try {
      await http.delete(
        '$url/follow',
        headers: {
          "Content-Type": "Application/json",
        },
      );

      _follow.removeAt(_follow.indexOf(id));

      print('delete');
      if (isSuccess) {
      } else {
        print(error);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }


  changeIcon() {
    icon = !icon;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ViewData with ChangeNotifier {
  final id;
  int view;
  final love;

  ViewData({this.love, this.id, this.view});
}

class View with ChangeNotifier {
  List<ViewData> _view = [];

  List<ViewData> get viewList => _view;
  static int count = 0;
  String error = '';
  bool isSuccess = false;

  Future<void> fitchAllViews({userId, BuildContext context}) async {
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/view?user=$userId",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });

      var jsonData = jsonDecode(res.body)['data'];

      final List<ViewData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          ViewData(
            love: element['love'],
            id: element['_id'],
            view: element['view'],
          ),
        );
      });
      _view = loadCourse;
      notifyListeners();
    } catch (error) {
      showErrorDialog(error, context);
      print(error);
    }
  }

// //to post review to the to the course
  Future<void> postView(
      {int newView, BuildContext context, String courseId}) async {
    try {
      var res = await http.post(
        'https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId/view',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({'view': newView}),
      );
      final source = jsonDecode(res.body);

      isSuccess = source['success'];

      _view.add(ViewData(
        view: source['view'],
      ));
      print(source);
    } catch (error) {
      print('view add error is =>' + error);
    }
    notifyListeners();
  }

  //to update favorite
  Future<void> updateFavorite({newFavorite, favId}) async {
    try {
      await http.put(
        'https://bootcamp-training-training.herokuapp.com/api/v1/view/$favId',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({'love': newFavorite}),
      );
    } catch (err) {
      print(err);
    }
  }
}

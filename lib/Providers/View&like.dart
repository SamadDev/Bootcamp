import 'dart:convert';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ViewData with ChangeNotifier {
  final id;
  int view;
  int like;
  final love;

  ViewData({this.love, this.id, this.view, this.like});
}

class View with ChangeNotifier {
  List<ViewData> _view = [];

  List<ViewData> get viewList => _view;
  static int count = 0;
  String error = '';
  bool isSuccess = false;

  Future<void> fitchAllViews(BuildContext context) async {
    try {
      var res = await http.get(

          ///views
          "https://bootcamp-training-training.herokuapp.com/api/v1/courses/5fd8631717e9f20e70aae8de/view",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      final jsonData = jsonDecode(res.body)['data'];

      // print(jsonData);
      final List<ViewData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          ViewData(
            love: element['love'],
            id: element['_id'],
            view: element['view'],
            like: element['like'],
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
      {int newView, int newLike, BuildContext context, String courseId}) async {
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
      print(error);
    }
    notifyListeners();
  }
}

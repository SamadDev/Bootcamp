import 'dart:convert';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MessageEnrollData {
  final id;
  final message;
  final enrollId;
  final user;

  MessageEnrollData({this.id, this.message, this.enrollId, this.user});
}

class MessageEnroll with ChangeNotifier {
  List<MessageEnrollData> _message = [];

  List<MessageEnrollData> get enrollList => _message;

  String error = '';
  bool isSuccess = false;

  Future<void> fitchMessageEnroll({BuildContext context}) async {
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/access",
          headers: {
            "Content-Type": "Application/json",
          });
      var jsonData = jsonDecode(res.body)['data'];
      List<MessageEnrollData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          MessageEnrollData(
              id: element['_id'],
              message: element['message'],
              enrollId: element['enroll'],
              user: element['user']),
        );
      });
      _message = loadCourse;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

// //to post message enroll to the to the course
  Future<void> postMessageEnroll(
      {String message, BuildContext context, String enrollId}) async {
    try {
      var res = await http.post(
        'https://bootcamp-training-training.herokuapp.com/api/v1/enroll/$enrollId/access',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({'message': message}),
      );
      final source = jsonDecode(res.body);
      _message.add(MessageEnrollData(
        message: source['message'],
      ));
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}

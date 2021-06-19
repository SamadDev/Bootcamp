import 'dart:convert';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MessageEnrollData {
  String sId;
  String message;
  AccessEnroll enroll;

  MessageEnrollData({this.sId, this.message, this.enroll});

  MessageEnrollData.fromJson( json) {
    sId = json['_id'];
    message = json['message'];
    enroll = AccessEnroll.fromJson(json['enroll']);
  }
}

class AccessEnroll {
  bool isVeryfiy;
  String course;
  String user;

  AccessEnroll({
    this.isVeryfiy,
    this.course,
    this.user,
  });

  AccessEnroll.fromJson(json) {
    isVeryfiy = json['isVeryfiy'];
    course = json['course'];
    user = json['user'];
  }
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
      print(jsonDecode(res.body));
      List jsonData = jsonDecode(res.body);

      List decodeList =
          jsonData.map((e) => MessageEnrollData.fromJson(e)).toList();
      _message = decodeList;
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

  List<MessageEnrollData> enrollMessageFilter = [];

  List<MessageEnrollData> messageFilter(String userId) {
    enrollMessageFilter =
        _message.where((element) => element.enroll.user == userId).toList();
    return enrollMessageFilter;
  }
}

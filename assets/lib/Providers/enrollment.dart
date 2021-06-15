import 'dart:convert';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EnrollData with ChangeNotifier {
  final id;
  final name;
  int phone;
  final address;
  final userCId;
  final courseId;
  bool isVerify;
  final courseTitle;

  EnrollData(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.userCId,
      this.courseId,
      this.courseTitle,
      this.isVerify});
}

class Enroll with ChangeNotifier {
  List<EnrollData> _enroll = [];

  List<EnrollData> get enrollList => _enroll;

  String error = '';
  bool isSuccess = false;

  Future<void> fitchEnroll({BuildContext context}) async {
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/enroll",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      List jsonData = jsonDecode(res.body)['data'];
      List<EnrollData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          EnrollData(
            id: element['_id'],
            name: element['name'],
            address: element['address'],
            phone: element['phone'],
            isVerify: element['isVeryfiy'],
            // courseTitle: element["course"]['title'],
            // courseId: element['course']['_id'],
            // userCId: element['course']['user']
          ),
        );
      });
      _enroll = loadCourse;
      notifyListeners();
    } catch (error) {
      print("enroll");
    }
  }

// //to post enroll to the to the course
  Future<void> postEnroll(
      {name, phone, address, BuildContext context, String courseId}) async {
    try {
      var res = await http.post(
        'https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId/enroll',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'address': address,
        }),
      );

      final source = jsonDecode(res.body);
      isSuccess = source['success'];
      error = source['error'];

      _enroll.add(EnrollData(
          name: source['name'],
          phone: source['phone'],
          address: source['address']));
      if (isSuccess) {
        Navigator.of(context).pushNamed(HomeScreen.route, arguments: courseId);
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      print('enroll add error is =>' + error);
    }
    notifyListeners();
  }

  //to update enroll
  Future<void> updateEnroll({newIsVerify, enrollId}) async {
    try {
      await http.put(
        'https://bootcamp-training-training.herokuapp.com/api/v1/enroll/$enrollId',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({'isVeryfiy': newIsVerify}),
      );
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteEnroll(String enrollId, BuildContext context) async {
    try {
      await http.delete(
        "https://bootcamp-training-training.herokuapp.com/api/v1/enroll/$enrollId",
        headers: {
          "Content-Type": "Application/json",
          "Authorization": "Bearer ${Auth.token}",
        },
      );
      final enrollIndex = _enroll
          .indexWhere((element) => element.id == enrollId); //to find index
      _enroll.removeAt(enrollIndex);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  bool enrollState = false;
  void changeState() {
    enrollState = !enrollState;
    notifyListeners();
  }
}

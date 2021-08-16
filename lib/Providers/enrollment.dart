import 'dart:convert';
import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EnrollData with ChangeNotifier {
  String isVeryfiy;
  String sId;
  String userId;
  String name;
  int phone;
  String address;
  EnrollCourse course;

  EnrollData(
      {this.isVeryfiy,
      this.sId,
      this.name,
      this.phone,
      this.address,
      this.userId,
      this.course});

  EnrollData.fromJson(Map<String, dynamic> json) {
    isVeryfiy = json['isVeryfiy'];
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    userId = json['user'];
    course = EnrollCourse.fromJson(json['course']);
  }
}

class EnrollCourse {
  String sId;
  String title;
  String photo;
  String user;

  EnrollCourse({this.sId, this.title, this.photo, this.user});

  EnrollCourse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    photo = json['photo'];
    user = json['user'];
  }
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
          });
      List jsonData = jsonDecode(res.body)['data'];
      List decodeList = jsonData.map((e) => EnrollData.fromJson(e)).toList();
      _enroll = decodeList;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

// //to post enroll to the to the course
  Future<void> postEnroll(
      {name, phone, address, BuildContext context, String courseId}) async {
    try {
      changeState();
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
      changeState();
      if (isSuccess) {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (ctx) => DetailHomeScreen(
                      id: courseId,
                      pending: 'pending',
                    )),);
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      print(error);
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
          .indexWhere((element) => element.sId == enrollId); //to find index
      _enroll.removeAt(enrollIndex);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<EnrollData> enrollDemand = [];

  List<EnrollData> enrollFilter(String userId) {
    enrollDemand =
        _enroll.where((element) => element.course.user == userId).toList();
    print(enrollDemand.length);
    return enrollDemand;
  }

  List<EnrollData> myEnrollList = [];

  List<EnrollData> myEnroll({userId}) {
    myEnrollList =
        _enroll.where((element) => element.userId == userId).toList();
    return myEnrollList;
  }

  EnrollData singleEnroll({courseId}) {
    return myEnrollList.firstWhere((element) => element.course.sId == courseId,
        orElse: () => EnrollData(isVeryfiy: 'false'));
  }

  bool isLoading = false;

  void changeState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}

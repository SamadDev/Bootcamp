import 'dart:convert';

import 'package:bootcamps/Pages/Bootcamps/BootcampsScreen.dart';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  final String role;
  final String sId;
  final String name;
  final String email;
  final String photo;
  final String createdAt;
  int iV;

  User(
      {this.role,
      this.sId,
      this.name,
      this.email,
      this.photo,
      this.createdAt,
      this.iV});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        role: data['role'],
        name: data['name'],
        email: data['email'],
        sId: data['_id'],
        photo: data['photo'],
        createdAt: data['createdAt'],
        iV: data['__V']);
  }
}

class Profile with ChangeNotifier {
  bool isSuccess;
  User userData;

  static String userId;
  static String userRole;
  Future<void> getUser(BuildContext context) async {
    if (userData != null) return;
    try {
      final res = await http.get(
        "https://bootcamp-training-training.herokuapp.com/api/v1/auth/me",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
      );

      final jsonData = jsonDecode(res.body)['data'];
      var role = jsonData['role'];
      var id = jsonData['_id'];
      userRole = role;
      userId = id;
      userData = User.fromJson(jsonData);
      print(userData);
    } catch (error) {
      print('profile error is $error');
    }
  }

  Future<void> updateDetailProfile({User newUser, BuildContext context}) async {
    try {
      var res = await http.put(
        'https://bootcamp-training-training.herokuapp.com/api/v1/auth/updatedetails',
        headers: {
          "Content-Type": "Application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({
          'name': newUser.name,
          'email': newUser.email,
          'photo': newUser.photo,
        }),
      );
      userData = newUser;
      print(res);
      notifyListeners();
      Navigator.of(context).pushNamed(BootcampsScreen.route);
    } catch (error) {
      showErrorDialog(error, context);
    }
  }
}

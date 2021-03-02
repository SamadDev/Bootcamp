import 'dart:convert';

import 'package:bootcamps/Pages/Bootcamps/BootcampsHomeScreen.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Map data;
  static String token;
  static bool isSuccess = true;
  static String error;
  String url =
      "https://bootcamp-training-training.herokuapp.com/api/v1/auth/register";

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      data = jsonDecode(response.body);
      isSuccess = data["success"];
      error = data['error'];
      if (isSuccess) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', data['token']);
        token = data['token'];

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BootcampsScreen()),
            (route) => false);
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> fetchTokenInLocal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');
  }
}

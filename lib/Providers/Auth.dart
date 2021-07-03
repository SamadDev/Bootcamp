import 'dart:convert';

import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Map data;
  static String token;
  static bool isSuccess = true;
  static String error;
  String url = "https://bootcamp-training-training.herokuapp.com/api/v1/auth/";

  Future<void> logIn(
      String email, String password, role, BuildContext context) async {
    try {
      var response = await http.post(url + 'logIn',
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode({"email": email, "password": password, "role": role}));

      data = jsonDecode(response.body);
      isSuccess = data["success"];
      error = data['error'];
      if (isSuccess) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', data['token']);
        token = data['token'];

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

//Sign up
  Future<void> signUp(
      {String name,
      String email,
      String password,
      String userRole,
      String photo,
      String userName,
      BuildContext context}) async {
    try {
      var response = await http.post(url + "register",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
            'role': userRole,
            'name': name,
            "userName": userName,
            "photo": photo
          }));

      data = jsonDecode(response.body);
      isSuccess = data["success"];
      error = data['error'];
      if (isSuccess) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', data['token']);
        token = data['token'];

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
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
  removeToken()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove('token');
    print(token);
  }
}

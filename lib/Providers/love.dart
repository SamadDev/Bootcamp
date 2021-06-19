import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage with ChangeNotifier {
  List<String> courseList = [];

  Future<void> fetchLoveList() async {
    try {
      if(courseList.isEmpty){addToLoveList('url'); courseList.removeAt(0);}
      SharedPreferences preferences = await SharedPreferences.getInstance();
      courseList = preferences.getStringList('course');
      print(courseList.length);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  addToLoveList(photo) async {
    try {
      courseList.add(photo);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('course', courseList);
      print('add');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  removeCourse(url) async {
    courseList.removeAt(courseList.indexOf(url));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('course', courseList);
    notifyListeners();
  }
}

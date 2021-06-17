import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage with ChangeNotifier {
  List<String> courseList = [];

  Future<void> fetchLoveList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      courseList = preferences.getStringList('course');
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

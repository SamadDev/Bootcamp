import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage with ChangeNotifier {
  List<String> courseList = [];
  List<String> idList=[];
  List<String> titleList=[];
  Future<void> fetchLoveList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      courseList = preferences.getStringList('course')??[];
      idList = preferences.getStringList('id')??[];
      idList = preferences.getStringList('title')??[];
      print(idList);
      print(courseList);
      print(titleList);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  addToLoveList(photo,id,title) async {
    try {
      courseList.add(photo);
      idList.add(id);
      idList.add(title);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('course', courseList);
      preferences.setStringList('id', idList);
      preferences.setStringList('title', titleList);
      print('add');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  removeCourse(url,id,title) async {
    courseList.removeAt(courseList.indexOf(url));
    idList.removeAt(idList.indexOf(id));
    idList.removeAt(idList.indexOf(title));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('course', courseList);
    preferences.setStringList('id', idList);
    preferences.setStringList('title', titleList);
    notifyListeners();
  }
}

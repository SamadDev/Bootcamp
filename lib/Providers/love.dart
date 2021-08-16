import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage with ChangeNotifier {
  List<String> courseList = [];
  List<String> idList = [];
  List<String> titleList = [];
  List<String> titleKrList = [];
  List<String> titleArList = [];

  Future<void> fetchLoveList() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      courseList = preferences.getStringList('course') ?? [];
      idList = preferences.getStringList('id') ?? [];
      titleList = preferences.getStringList('title') ?? [];
      titleKrList = preferences.getStringList('titleKr') ?? [];
      titleArList = preferences.getStringList('titleAr') ?? [];
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  addToLoveList(photo, id, title, titleKr, titleAr) async {
    try {
      courseList.add(photo);
      idList.add(id);
      titleList.add(title);
      titleKrList.add(titleKr);
      titleArList.add(titleAr);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('course', courseList);
      preferences.setStringList('id', idList);
      preferences.setStringList('title', titleList);
      preferences.setStringList('titleKr', titleKrList);
      preferences.setStringList('titleAr', titleArList);
      print('$titleArList $titleKrList$titleList');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  removeCourse(url, id, title, titleKr, titleAr) async {
    try {
      courseList.removeAt(courseList.indexOf(url));
      idList.removeAt(idList.indexOf(id));
      titleList.removeAt(titleList.indexOf(title));
      titleKrList.removeAt(titleKrList.indexOf(titleKr));
      titleArList.removeAt(titleArList.indexOf(titleAr));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('course');
      preferences.remove('id');
      preferences.remove('title');
      preferences.remove('titleKr');
      preferences.remove('titleAr');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

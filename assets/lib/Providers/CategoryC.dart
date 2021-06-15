import 'package:flutter/material.dart';

import '../Style/style.dart';

class CourseCategoryData {
  final id;
  final type;
  final color;

  CourseCategoryData({this.id, this.type, this.color});
}

class CourseC with ChangeNotifier {
  List<CourseCategoryData> _categoryList = [
    CourseCategoryData(type: "Technology", color: AppTheme.green, id: 1),
    CourseCategoryData(type: "Business", color: AppTheme.orange, id: 2),
    CourseCategoryData(type: "Language", color: AppTheme.navy, id: 3),
    CourseCategoryData(type: "Art", color: AppTheme.green, id: 4),
    CourseCategoryData(type: "Fitness", color: AppTheme.lightBlueAccent, id: 6),
    CourseCategoryData(type: "Sport", color: AppTheme.green, id: 7),
  ];

  List<CourseCategoryData> get categoryList => _categoryList;

  CourseCategoryData findById(String id) {
    return _categoryList.firstWhere((element) => element.id == id);
  }
}

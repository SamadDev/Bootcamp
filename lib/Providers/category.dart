import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

import '../Style/style.dart';

class CategoryData {
  final id;
  final type;
  final icon;
  final color;

  CategoryData({this.id, this.type, this.icon, this.color});
}

class Category with ChangeNotifier {
  List<CategoryData> _categoryList = [
    CategoryData(
        type: "Technology",
        icon: LineIcon.laptop(
          size: 35,
        ),
        color: AppTheme.green.withOpacity(0.4),
        id: 1),
    CategoryData(
        type: "Business",
        icon: LineIcon.businessTime(
          size: 35,
        ),
        color: AppTheme.orange.withOpacity(0.4),
        id: 2),
    CategoryData(
        type: "Language",
        icon: LineIcon.language(
          size: 35,
        ),
        color: AppTheme.navy.withOpacity(0.4),
        id: 3),
    CategoryData(
        type: "Art",
        icon: LineIcon.artstation(
          size: 35,
        ),
        color: AppTheme.black3,
        id: 4),
    CategoryData(
        type: "Fitness",
        icon: LineIcon.dumbbell(
          size: 35,
        ),
        color: AppTheme.lightBlueAccent.withOpacity(0.4),
        id: 6),
    CategoryData(
        type: "Sport",
        icon: LineIcon.baseballBall(
          size: 35,
        ),
        color: AppTheme.green.withOpacity(0.4),
        id: 7),
  ];

  List<CategoryData> get categoryList => _categoryList;
}

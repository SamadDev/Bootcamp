import 'package:bootcamps/Localization/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Style/style.dart';

List category(context){
  final language=Provider.of<Language>(context).words;
  return [
    {
      "title":language['technology'] ,
      'value': 'Technology',
      "color": AppTheme.lightBlueAccent.withOpacity(0.1),
      "icon": Image.asset('assets/images/laptop.png'),
      "id": '0',
    },
    {
      "title": language['business'],
      'value': 'Business',
      "color": AppTheme.orange.withOpacity(0.1),
      "icon": Image.asset('assets/images/financial-profit.png'),
      "id": '1',
    },
    {
      "title": language['language'],
      'value': 'Language',
      "color": AppTheme.lightBlueAccent.withOpacity(0.1),
      "icon": Image.asset(
        'assets/images/translate.png',
        fit: BoxFit.fill,
      ),
      "id": '2',
    },
    {
      "title": language['sport'],
      'value': 'Sport',
      "color": AppTheme.orange.withOpacity(0.1),
      "icon": Image.asset('assets/images/sports.png'),
      "id": '3',
    },
    {
      "title": language['art'],
      'value': 'Art',
      "color": AppTheme.lightBlueAccent.withOpacity(0.1),
      "icon": Image.asset('assets/images/art-and-design.png'),
      "id": '4',
    },
    {
      "title": language['fitness'],
      'value': 'Fitness',
      "color": AppTheme.orange.withOpacity(0.1),
      "icon": Image.asset('assets/images/barbell.png'),
      "id": '5',
    },];

}
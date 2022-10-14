import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language with ChangeNotifier {
  // language dir
  String languageDirection = 'ltr';

  // language code
  String languageCode = 'en';

  void setLanguage(code, direction) async {
    languageCode = code;
    languageDirection = direction;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('languageCode', languageCode);
    sharedPreferences.setString('languageDirection', languageDirection);
    notifyListeners();
  }

  Future<void> getLanguageDataInLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    languageCode = sharedPreferences.getString('languageCode') ?? 'en';
    languageDirection =
        sharedPreferences.getString('languageDirection') ?? 'ltr';
    print(languageCode);
    notifyListeners();
  }

  Map<String, dynamic> get words => _words[languageCode];

// language words
  Map _words = {
    'kr': {
      'top': 'مالەو',
      'populate': 'دلخوازەکان',
      'recent': 'نوێترینەکان',
      'seeAll': 'بینینی هەموو',
      'courses': 'کۆرسەکان',
      'view': 'بینین',
      'technology': 'تێکنەلۆجی',
      'business': 'بزنز',
      "language": 'زمان',
      'sport': 'وەرزش',
      'art':'هونەر',
      'fitness': 'لەشجوانی',
      'search': 'گەڕان ...',
      'home': 'ماڵەوە',
      'search1': "گەڕان",
      'notification': 'ئاگەداری',
      'more': 'زیاتر',
      'retry': 'هەوڵدانەوە'
    },
    'en': {
      'top': 'Home',
      'populate': 'Most Populate',
      'recent': 'Most Recent',
      'seeAll': 'See All',
      'courses': 'courses',
      'view': 'view',
      'technology': 'Technology',
      'business': 'Business',
      "language": 'Language',
      'sport': 'sport',
      'fitness': 'Fitness',
      'art':'Art',
      'search': 'Search ...',
      'home': 'Home',
      'search1': 'search',
      'notification': 'Notification',
      'more': 'More',
      'retry': 'retry'
    },
    'ar': {
      'top': 'البیت',
      'populate': 'Most Populate',
      'recent': 'Most Recent',
      'seeAll': 'See All',
      'courses': 'courses',
      'view': 'view',
      'technology': 'Technology',
      'business': 'Business',
      "language": 'Language',
      'sport': 'sport',
      'fitness': 'Fitness',
      'home': 'Home',
      'search': 'Search',
      'notification': 'Notification',
      'more': 'More'
    }
  };
}

import 'package:flutter/cupertino.dart';

class Language with ChangeNotifier {
  // language dir
  String languageDirection = 'ltr';

  // language code
  String languageCode = 'en';

  void setLanguage(code, direction) async {
    languageCode = code;
    languageDirection = direction;
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString('languageCode', languageCode);
    // sharedPreferences.setString('languageDirection', direction);
    notifyListeners();
  }

  Future<void> getLanguageDataInLocal() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // languageCode = sharedPreferences.getString('languageCode') ?? 'en';
    // languageDirection =
    //     sharedPreferences.getString('languageDirection') ?? 'ltr';
    notifyListeners();
  }

  Map<String, dynamic> get words => _words[languageCode];

// language words
  Map _words = {
    'kr': {'bootcamp': 'بۆۆتکامپ'},
    'en': {'bootcamp': 'bootcamp'}
  };
}

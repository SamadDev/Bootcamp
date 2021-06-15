import 'package:flutter/cupertino.dart';

class StateChange with ChangeNotifier {
  //loading state
  bool isLoading = false;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  //show or hide password
  bool isShow = true;

  void changeIsShow() {
    isShow = !isShow;
    notifyListeners();
  }
}

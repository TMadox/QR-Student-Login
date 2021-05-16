import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  bool isloading = false;
  String result;
  void setresult(String input) {
    result = input;
    notifyListeners();
  }

  void setloadingstate() {
    isloading = !isloading;
    notifyListeners();
  }
}

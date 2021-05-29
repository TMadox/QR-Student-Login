import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  bool isloading = false;
  String result;
  List selecteditems = [];
  bool searchactive = false;
  String searchedcourse = "";
  bool isadminuser=false;
  void setresult(String input) {
    result = input;
    notifyListeners();
  }

  void setloadingstate() {
    isloading = !isloading;
    notifyListeners();
  }

  void addtoselecteditems(String item) {
    selecteditems.add(item);
    notifyListeners();
  }

  void removefromselecteditems(String item) {
    selecteditems.remove(item);
    notifyListeners();
  }

  void setsearchwidth() {
    searchactive = !searchactive;
    notifyListeners();
  }

  void setsearchedcourse(String input) {
    searchedcourse = input;
    notifyListeners();
  }
}

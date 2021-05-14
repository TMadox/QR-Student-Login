import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  bool isloading = false;

  void setloadingstate() {
    isloading = !isloading;
    notifyListeners();
  }
}

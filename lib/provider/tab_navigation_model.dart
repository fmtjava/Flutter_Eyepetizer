import 'package:flutter/material.dart';

class TabNavigationModel with ChangeNotifier {
  int currentIndex = 0;

  changeBottomTabIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

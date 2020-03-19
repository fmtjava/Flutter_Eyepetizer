import 'package:flutter/material.dart';

class PhotoGalleryModel extends ChangeNotifier {
  int currentIndex = 1;

  changeIndex(int index) {
    this.currentIndex = index + 1;
    notifyListeners();
  }
}

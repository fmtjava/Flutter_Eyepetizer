import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';

class PhotoGalleryModel extends BaseChangeNotifierModel {
  int currentIndex = 1;

  changeIndex(int index) {
    this.currentIndex = index + 1;
    notifyListeners();
  }
}

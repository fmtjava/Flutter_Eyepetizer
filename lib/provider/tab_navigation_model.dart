import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';

class TabNavigationModel extends BaseChangeNotifierModel {
  int currentIndex = 0;

  changeBottomTabIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

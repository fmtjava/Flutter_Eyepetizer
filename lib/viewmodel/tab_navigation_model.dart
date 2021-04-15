

import 'package:lib_core/viewmodel/base_change_notifier_model.dart';

class TabNavigationModel extends BaseChangeNotifierModel {
  int currentIndex = 0;

  changeBottomTabIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

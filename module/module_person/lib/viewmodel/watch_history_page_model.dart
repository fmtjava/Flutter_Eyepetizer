import 'dart:convert';

import 'package:lib_core/viewmodel/base_change_notifier_model.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_person/repository/history_repository.dart';

class WatchHistoryPageModel extends BaseChangeNotifierModel {
  List<Data> itemList = [];
  List<String> watchList = [];

  void loadData() {
    watchList = HistoryRepository.loadHistoryData();
    if (watchList != null) {
      var list = watchList.map((value) {
        return Data.fromJson(json.decode(value));
      }).toList();
      itemList = list;
      notifyListeners();
    }
  }

  void remove(int index) {
    watchList.removeAt(index);
    HistoryRepository.saveHistoryData(watchList);
    loadData();
  }
}

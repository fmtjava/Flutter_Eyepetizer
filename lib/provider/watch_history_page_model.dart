import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/history_repository.dart';

class WatchHistoryPageModel with ChangeNotifier {
  List<Data> itemList = [];
  List<String> watchList = [];

  void loadData() async {
    watchList = await HistoryRepository.loadHistoryData();
    if (watchList != null) {
      var list = watchList.map((value) {
        return Data.fromJson(json.decode(value));
      }).toList();
      itemList = list;
      notifyListeners();
    }
  }

  void remove(int index) async {
    watchList.removeAt(index);
    HistoryRepository.saveHistoryData(watchList);
    loadData();
  }
}

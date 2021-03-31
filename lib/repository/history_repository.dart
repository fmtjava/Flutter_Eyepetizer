import 'dart:convert';

import 'package:flutter_eyepetizer/db/CacheManager.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class HistoryRepository {
  static saveWatchHistory(Data data) async {
    List<String> watchList = loadHistoryData();

    var jsonParam = data.toJson();
    var jsonStr = json.encode(jsonParam);
    if (!watchList.contains(jsonStr)) {
      watchList.add(json.encode(jsonParam));
      CacheManager.getInstance().set(Constant.watchHistoryList, watchList);
    }
  }

  static List<String> loadHistoryData() {
    List<dynamic> originList = CacheManager.getInstance()
        .get<List<dynamic>>(Constant.watchHistoryList);

    List<String> watchList;

    if (originList == null) {
      watchList = [];
    } else {
      watchList = originList.map((e) => e.toString()).toList();
    }
    return watchList;
  }

  static saveHistoryData(List<String> watchHistoryList) {
    CacheManager.getInstance().set(Constant.watchHistoryList, watchHistoryList);
  }
}

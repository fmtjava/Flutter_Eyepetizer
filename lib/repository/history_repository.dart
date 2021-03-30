import 'dart:convert';

import 'package:flutter_eyepetizer/db/CacheManager.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class HistoryRepository {
  static saveWatchHistory(Data data) async {
    List<String> watchList =
        CacheManager.getInstance().get<List<String>>(Constant.watchHistoryList);
    if (watchList == null) {
      watchList = [];
    }
    var jsonParam = data.toJson();
    var jsonStr = json.encode(jsonParam);
    if (!watchList.contains(jsonStr)) {
      watchList.add(json.encode(jsonParam));
      CacheManager.getInstance().set(Constant.watchHistoryList, watchList);
    }
  }

  static List<String> loadHistoryData() {
    return CacheManager.getInstance()
        .get<List<String>>(Constant.watchHistoryList);
  }

  static saveHistoryData(List<String> watchHistoryList) {
    CacheManager.getInstance().set(Constant.watchHistoryList, watchHistoryList);
  }
}

import 'dart:convert';

import 'package:lib_cache/cache_manager.dart';
import 'package:module_common/model/common_item_model.dart';

class HistoryRepository {
  static const String watch_history_list_key = "watch_history_list";

  static saveWatchHistory(Data data) async {
    List<String> watchList = loadHistoryData();

    var jsonParam = data.toJson();
    var jsonStr = json.encode(jsonParam);
    if (!watchList.contains(jsonStr)) {
      watchList.add(json.encode(jsonParam));
      CacheManager.getInstance().set(watch_history_list_key, watchList);
    }
  }

  static List<String> loadHistoryData() {
    List<dynamic> originList =
        CacheManager.getInstance().get<List<dynamic>>(watch_history_list_key);

    List<String> watchList;

    if (originList == null) {
      watchList = [];
    } else {
      watchList = originList.map((e) => e.toString()).toList();
    }
    return watchList;
  }

  static saveHistoryData(List<String> watchHistoryList) {
    CacheManager.getInstance().set(watch_history_list_key, watchHistoryList);
  }
}

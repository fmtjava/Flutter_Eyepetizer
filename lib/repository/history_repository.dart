import 'dart:convert';

import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/app_manager.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class HistoryRepository {

  static saveWatchHistory(Data data) async {
    List<String> watchList = AppManager.prefs.getStringList(Constant.watchHistoryList);
    if (watchList == null) {
      watchList = List();
    }
    var jsonParam = data.toJson();
    var jsonStr = json.encode(jsonParam);
    if (!watchList.contains(jsonStr)) {
      watchList.add(json.encode(jsonParam));
      AppManager.prefs.setStringList(Constant.watchHistoryList, watchList);
    }
  }

  static Future<List<String>> loadHistoryData() async{
    return AppManager.prefs.getStringList(Constant.watchHistoryList);
  }

  static saveHistoryData(List<String> watchHistoryList) async{
    AppManager.prefs.setStringList(Constant.watchHistoryList, watchHistoryList);
  }
}

import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {

  static Future<List<String>> loadHistoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(Constant.watchHistoryList);
  }

  static saveHistoryData(List<String> watchHistoryList) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Constant.watchHistoryList, watchHistoryList);
  }
}

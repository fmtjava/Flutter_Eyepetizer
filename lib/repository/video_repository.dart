import 'dart:convert';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VideoRepository {
  static Future<Issue> getVideoRelateList(int id) async {
    var url = 'http://baobab.kaiyanapp.com/api/v4/video/related?id=$id';
    var response = await http.get(url, headers: HttpConstant.httpHeader);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return Issue.fromJson(result);
    } else {
      throw Exception('"Request failed with status: ${response.statusCode}"');
    }
  }

  static saveWatchHistory(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchList = prefs.getStringList(Constant.watchHistoryList);
    if (watchList == null) {
      watchList = List();
    }
    var jsonParam = item.toJson();
    var jsonStr = json.encode(jsonParam);
    if (!watchList.contains(jsonStr)) {
      watchList.add(json.encode(jsonParam));
      prefs.setStringList(Constant.watchHistoryList, watchList);
    }
  }
}

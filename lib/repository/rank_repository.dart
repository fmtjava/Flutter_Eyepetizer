import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/model/tab_info_model.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankRepository {
  static Future<TabInfoModel> getTabInfo() async {
    var url = 'http://baobab.kaiyanapp.com/api/v4/rankList';
    var response = await http.get(url, headers: HttpConstant.httpHeader);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TabInfoModel.fromJson(result);
    } else {
      throw Exception('"Request failed with status: ${response.statusCode}"');
    }
  }

  static Future<Issue> getRankList(String url) async {
    var response = await http.get(url, headers: HttpConstant.httpHeader);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return Issue.fromJson(result);
    } else {
      throw Exception('"Request failed with status: ${response.statusCode}"');
    }
  }
}

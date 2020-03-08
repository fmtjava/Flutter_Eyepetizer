import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchRepository {
  static Future<List<String>> getKeyWordList() async {
    final url = 'http://baobab.kaiyanapp.com/api/v3/queries/hot';
    var response = await http.get(url, headers: HttpConstant.httpHeader);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      String responseStr = utf8decoder.convert(response.bodyBytes);
      var resJson = responseStr.substring(1, responseStr.toString().length - 1);
      List<String> strList = resJson.split(',');
      List<String> keywords = [];
      for (var keyword in strList) {
        String str = keyword.substring(1, keyword.length - 1);
        keywords.add(str);
      }
      return keywords;
    } else {
      throw Exception('"Request failed with status: ${response.statusCode}"');
    }
  }

  static Future<Issue> getSearchVideoList(String url) async {
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

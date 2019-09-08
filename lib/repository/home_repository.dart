import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeRepository {
  static Future<IssueEntity> getHomeList(String url) async {
    var response = await http.get(url, headers: HttpConstant.httpHeader);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return IssueEntity.fromJson(result);
    } else {
      throw Exception('"Request failed with status: ${response.statusCode}"');
    }
  }
}

import 'dart:convert';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  static Future<List<CategoryModel>> getCategoryList() async {
    final url = 'http://baobab.kaiyanapp.com/api/v4/categories';
    var response = await http.get(url, headers: HttpConstant.httpHeader);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      List responseList = json.decode(utf8decoder.convert(response.bodyBytes));
      List<CategoryModel> categoryList =
          responseList.map((model) => CategoryModel.fromJson(model)).toList();
      return categoryList;
    } else {
      throw Exception('"Request failed with status: ${response.statusCode}"');
    }
  }

  static Future<Issue> getCategoryDetailList(String url) async {
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

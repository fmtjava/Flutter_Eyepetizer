import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpManager {
  static Utf8Decoder utf8decoder = Utf8Decoder();

  //网络请求封装，通过方法回调执行的结果(成功或失败)
  //网络请求封装方式一：采用回调函数处理请求结果，类似Android开发
  static getData(String url,
      {Map<String, String>? headers,
      Function? success,
      Function? fail,
      Function? complete}) async {
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        success?.call(result);
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      fail?.call(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  //网络请求封装方式二：返回Future，结合 then ==> catchError ==>whenComplete,类似JS
  static Future requestData(String url, {Map<String, String>? headers}) async {
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        return result;
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      Future.error(e);
    }
  }
}

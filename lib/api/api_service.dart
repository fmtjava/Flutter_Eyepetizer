import 'dart:convert';

import 'package:flutter_eyepetizer/util/app_manager.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const base_url = 'http://baobab.kaiyanapp.com/api/';

  static const feed_url = '${base_url}v2/feed?num=1';

  static const follow_url = '${base_url}v4/tabs/follow';

  static const community_url = '${base_url}v7/community/tab/rec';

  static const rank_url = '${base_url}v4/rankList';

  static const category_url = '${base_url}v4/categories';

  static const video_related_url = '${base_url}v4/video/related?id=';

  static const keyword_url = '${base_url}v3/queries/hot';

  static const topics_url = '${base_url}v3/specialTopics';

  static const topics_detail_url = '${base_url}v3/lightTopics/internal/';

  static const search_url = "${base_url}v1/search?&num=10&start=10&query=";

  static const category_video_url = '${base_url}v4/categories/videoList?';

  //网络请求封装，通过方法回调执行的结果(成功或失败)
  static getData(String url,
      {Function success, Function fail, Function complete}) async {
    try {
      var response = await http.get(url, headers: HttpConstant.httpHeader);
      if (response.statusCode == 200) {
        var result = json.decode(AppManager.utf8decoder.convert(response.bodyBytes));
        success(result);
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }
}

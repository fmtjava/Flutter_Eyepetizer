import 'package:module_common/constant/http_constant.dart';

class URLs {
  static String feedUrl = '${HttpConstant.baseUrl}v2/feed?num=1';

  static String keywordUrl = '${HttpConstant.baseUrl}v3/queries/hot';

  static String searchUrl = "${HttpConstant.baseUrl}v1/search?query=";
}

import 'package:module_common/constant/http_constant.dart';

class URLs {
  static String communityUrl = '${HttpConstant.baseUrl}v7/community/tab/rec';

  static String categoryUrl = '${HttpConstant.baseUrl}v4/categories';

  static String followUrl = '${HttpConstant.baseUrl}v4/tabs/follow';

  static String categoryVideoUrl =
      '${HttpConstant.baseUrl}v4/categories/videoList?';

  static String newsUrl =
      '${HttpConstant.baseUrl}v7/information/list?vc=6030000&deviceModel=';

  static String topicsDetailUrl =
      '${HttpConstant.baseUrl}v3/lightTopics/internal/';

  static String topicsUrl = '${HttpConstant.baseUrl}v3/specialTopics';

  static String videoRelatedUrl = '${HttpConstant.baseUrl}v4/video/related?id=';
}

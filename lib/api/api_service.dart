class ApiService {
  ApiService._();

  static const base_url = 'http://baobab.kaiyanapp.com/api/';

  static const feed_url = '${base_url}v2/feed?num=1';

  static const follow_url = '${base_url}v4/tabs/follow';

  static const community_url = '${base_url}v7/community/tab/rec';

  static const category_url = '${base_url}v4/categories';

  static const video_related_url = '${base_url}v4/video/related?id=';

  static const keyword_url = '${base_url}v3/queries/hot';

  static const topics_url = '${base_url}v3/specialTopics';

  static const topics_detail_url = '${base_url}v3/lightTopics/internal/';

  static const news_url =
      '${base_url}v7/information/list?vc=6030000&deviceModel=';

  static const search_url = "${base_url}v1/search?query=";

  static const category_video_url = '${base_url}v4/categories/videoList?';
}

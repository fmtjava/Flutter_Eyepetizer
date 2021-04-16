import 'dart:io';
import 'package:lib_core/viewmodel/paging_list_model.dart';
import 'package:module_discover/constant/api_service.dart';
import 'package:module_discover/model/news_model.dart';

class NewsPageModel extends PagingListModel<NewsItemModel, NewsModel> {

  @override
  String getUrl() {
    String deviceModel = Platform.isAndroid ? "Android" : "IOS";
    return URLs.newsUrl + deviceModel;
  }

  @override
  String getNextUrl(NewsModel model) {
    String deviceModel = Platform.isAndroid ? "Android" : "IOS";
    return "${model.nextPageUrl}&vc=6030000&deviceModel=$deviceModel";
  }

  @override
  NewsModel getModel(Map<String, dynamic> json) {
    return NewsModel.fromJson(json);
  }

}

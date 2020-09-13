
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/topic_model.dart';
import 'package:flutter_eyepetizer/provider/paging_list_model.dart';

class TopicPageModel extends PagingListModel<TopicItemModel,TopicModel>{

  @override
  String getUrl() {
    return ApiService.topics_url;
  }

  @override
  TopicModel getModel(Map<String, dynamic> json) {
    return TopicModel.fromJson(json);
  }

}
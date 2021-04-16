
import 'package:lib_core/viewmodel/paging_list_model.dart';
import 'package:module_discover/constant/api_service.dart';
import 'package:module_discover/model/topic_model.dart';

class TopicPageModel extends PagingListModel<TopicItemModel,TopicModel>{

  @override
  String getUrl() {
    return URLs.topicsUrl;
  }

  @override
  TopicModel getModel(Map<String, dynamic> json) {
    return TopicModel.fromJson(json);
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class TopicDetailPageModel with ChangeNotifier {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> itemList = [];

  bool loading = true;

  void loadTopicDetailData(int id) {
    ApiService.getData('${ApiService.topics_detail_url}$id',
        success: (result) {
          topicDetailModel = TopicDetailModel.fromJson(result);
          itemList = topicDetailModel.itemList;
          loading = false;
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          loading = false;
        },
        complete: () => notifyListeners());
  }
}

import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/viewmodel/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';

class TopicDetailPageModel extends BaseChangeNotifierModel {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> itemList = [];

  int _id;

  void loadTopicDetailData(int id) {
    _id = id;
    ApiService.requestData('${ApiService.topics_detail_url}$id').then((res) {
      topicDetailModel = TopicDetailModel.fromJson(res);
      itemList = topicDetailModel.itemList;
      viewState = ViewState.content;
    }).catchError((e) {
      showError(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    loadTopicDetailData(_id);
  }
}

import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class TopicDetailPageModel extends BaseChangeNotifierModel {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> itemList = [];

  bool loading = true;
  bool error = false;
  int _id;

  void loadTopicDetailData(int id) {
    _id = id;
    ApiService.requestData('${ApiService.topics_detail_url}$id').then((res) {
      topicDetailModel = TopicDetailModel.fromJson(res);
      itemList = topicDetailModel.itemList;
      loading = false;
      error = false;
    }).catchError((e) {
      ToastUtil.showError(e.toString());
      loading = false;
      error = true;
    }).whenComplete(() => notifyListeners());
  }

  retry() {
    loading = true;
    notifyListeners();
    loadTopicDetailData(_id);
  }
}

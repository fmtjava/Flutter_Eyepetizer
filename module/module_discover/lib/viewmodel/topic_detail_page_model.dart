import 'package:lib_core/viewmodel/base_change_notifier_model.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:module_discover/constant/api_service.dart';
import 'package:module_discover/model/topic_detail_model.dart';

class TopicDetailPageModel extends BaseChangeNotifierModel {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData>? itemList = [];

  late int _id;

  void loadTopicDetailData(int id) {
    _id = id;
    HttpManager.requestData('${URLs.topicsDetailUrl}$id').then((res) {
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

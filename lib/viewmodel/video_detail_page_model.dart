import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:lib_core/viewmodel/base_change_notifier_model.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/toast_util.dart';

class VideoDetailPageModel extends BaseChangeNotifierModel {
  List<Item> itemList = [];
  int _videoId;

  void loadVideoRelateData(int id) {
    _videoId = id;
    HttpManager.requestData('${ApiService.video_related_url}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList;
      viewState = ViewState.content;
    }).catchError((e) {
      showError(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    loadVideoRelateData(_videoId);
  }
}

import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/viewmodel/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';

class VideoDetailPageModel extends BaseChangeNotifierModel {
  List<Item> itemList = [];
  int _videoId;

  void loadVideoRelateData(int id) {
    _videoId = id;
    ApiService.requestData('${ApiService.video_related_url}$id').then((res) {
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

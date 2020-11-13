import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class VideoDetailPageModel extends BaseChangeNotifierModel {
  List<Item> itemList = [];
  bool loading = true;
  bool error = false;
  int _videoId;

  void loadVideoRelateData(int id) {
    _videoId = id;
    ApiService.requestData('${ApiService.video_related_url}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList;
      loading = false;
      error = false;
    }).catchError((e) {
      ToastUtil.showError(e.toString());
      loading = false;
      error = true;
    }).whenComplete(() => notifyListeners());
  }

  void retry() {
    loading = true;
    notifyListeners();
    loadVideoRelateData(_videoId);
  }
}

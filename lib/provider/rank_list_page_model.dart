import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPageModel extends BaseChangeNotifierModel {
  List<Item> itemList = [];
  bool loading = true;
  bool error = false;
  String apiUrl;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(String apiUrl) {
    this.apiUrl = apiUrl;
  }

  void loadData(){
    ApiService.getData(apiUrl,
        success: (result) {
          Issue issueModel = Issue.fromJson(result);

          itemList = issueModel.itemList;
          loading = false;
          error = false;
          refreshController.refreshCompleted();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
          error = true;
        },
        complete: () => notifyListeners());
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}

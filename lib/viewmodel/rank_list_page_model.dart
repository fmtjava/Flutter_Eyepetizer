import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/viewmodel/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPageModel extends BaseChangeNotifierModel {
  List<Item> itemList = [];
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
          viewState = ViewState.content;
          refreshController.refreshCompleted();
        },
        fail: (e) {
          showError(e.toString());
          refreshController.refreshFailed();
          viewState = ViewState.error;
        },
        complete: () => notifyListeners());
  }

  retry(){
    viewState = ViewState.loading;
    notifyListeners();
    loadData();
  }
}

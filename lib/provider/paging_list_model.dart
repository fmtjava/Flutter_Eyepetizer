import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/paging_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class PagingListModel<T, M extends PagingModel<T>>
    with ChangeNotifier {
  List<T> itemList = [];
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refresh() {
    ApiService.getData(getUrl(),
        success: (json) {
          M model = getModel(json);
          itemList = model.itemList;
          doExtraAfterRefresh();
          loading = false;
          nextPageUrl = getNextUrl(model);
          refreshController.refreshCompleted();
          refreshController.footerMode.value = LoadStatus.canLoading;
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
        },
        complete: () => notifyListeners());
  }

  void loadMore() {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    ApiService.getData(nextPageUrl, success: (json) {
      M model = getModel(json);
      itemList.addAll(model.itemList);
      loading = false;
      nextPageUrl = getNextUrl(model);
      refreshController.loadComplete();

      notifyListeners();
    }, fail: (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    });
  }

  void doExtraAfterRefresh() {

  }

  String getUrl();

  String getNextUrl(M model){
    return model.nextPageUrl;
  }

  M getModel(Map<String, dynamic> json);
}

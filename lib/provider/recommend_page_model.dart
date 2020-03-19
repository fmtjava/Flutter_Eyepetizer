import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/recommend_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPageModel with ChangeNotifier {
  List<RecommendItem> itemList = [];
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  refresh() {
    ApiService.getData(ApiService.community_url,
        success: (result) {
          RecommendModel recommendModel = RecommendModel.fromJson(result);

          itemList = recommendModel.itemList;
          itemList.removeWhere((item) {
            return item.type == 'horizontalScrollCard';
          });

          loading = false;
          nextPageUrl = recommendModel.nextPageUrl;
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

  loadMore() {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }
    ApiService.getData(nextPageUrl, success: (result) {
      RecommendModel recommendModel = RecommendModel.fromJson(result);

      itemList.addAll(recommendModel.itemList);

      loading = false;
      nextPageUrl = recommendModel.nextPageUrl;
      refreshController.loadComplete();

      notifyListeners();
    }, fail: (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    });
  }
}

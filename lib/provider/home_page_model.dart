import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageModel with ChangeNotifier {
  List<Item> bannerList = [];
  List<Item> itemList = [];
  int currentIndex = 0;
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  refresh() async {
    ApiService.getData(ApiService.feed_url,
        success: (result) async {
          IssueEntity issueEntity = IssueEntity.fromJson(result);
          List<Item> list = issueEntity.issueList[0].itemList;
          list.removeWhere((item) {
            return item.type == 'banner2';
          });

          itemList.clear();
          itemList.add(Item()); //为Banner占位
          bannerList = list;
          loading = false;

          nextPageUrl = issueEntity.nextPageUrl;
          refreshController.refreshCompleted();
          refreshController.footerMode.value = LoadStatus.canLoading;
          await loadMore();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
        },
        complete: () => notifyListeners());
  }

  Future loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    ApiService.getData(nextPageUrl, success: (result) {
      IssueEntity issueEntity = IssueEntity.fromJson(result);
      List<Item> list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });

      itemList.addAll(list);
      nextPageUrl = issueEntity.nextPageUrl;
      refreshController.loadComplete();
      notifyListeners();
    }, fail: (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    });
  }

  changeBannerIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

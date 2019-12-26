import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/home_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const DEFAULT_URL = 'http://baobab.kaiyanapp.com/api/v2/feed?num=1';

class HomePageModel with ChangeNotifier {
  List<Item> bannerList = [];
  List<Item> itemList = [];
  int currentIndex = 0;
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refresh() async {
    var url = DEFAULT_URL;
    try {
      IssueEntity issueEntity = await HomeRepository.getHomeList(url);
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
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
      loading = false;
    } finally {
      notifyListeners();
    }
  }

  Future loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }
    try {
      IssueEntity issueEntity = await HomeRepository.getHomeList(nextPageUrl);
      List<Item> list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });

      itemList.addAll(list);
      nextPageUrl = issueEntity.nextPageUrl;
      refreshController.loadComplete();
      notifyListeners();
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    }
  }

  void changeBannerIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

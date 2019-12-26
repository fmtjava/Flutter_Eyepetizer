import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/follow_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const DEFAULT_URL = 'http://baobab.kaiyanapp.com/api/v4/tabs/follow';

class FollowPageModel with ChangeNotifier {
  List<Item> itemList = [];
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refresh() async {
    var url = DEFAULT_URL;
    try {
      Issue issueModel = await FollowRepository.getFollowList(url);

      itemList = issueModel.itemList;
      loading = false;
      nextPageUrl = issueModel.nextPageUrl;
      refreshController.refreshCompleted();
      refreshController.footerMode.value = LoadStatus.canLoading;
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
      loading = false;
    } finally {
      notifyListeners();
    }
  }

  void loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }
    try {
      Issue issue = await FollowRepository.getFollowList(nextPageUrl);

      itemList.addAll(issue.itemList);
      loading = false;
      nextPageUrl = issue.nextPageUrl;
      refreshController.loadComplete();

      notifyListeners();
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    }
  }
}

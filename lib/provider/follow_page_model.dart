import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowPageModel with ChangeNotifier {
  List<Item> itemList = [];
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refresh(){
    ApiService.getData(ApiService.follow_url,success: (result){
      Issue issueModel = Issue.fromJson(result);

      itemList = issueModel.itemList;
      loading = false;
      nextPageUrl = issueModel.nextPageUrl;
      refreshController.refreshCompleted();
      refreshController.footerMode.value = LoadStatus.canLoading;
    },fail: (e){
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
      loading = false;
    },complete: ()=>notifyListeners());
  }

  void loadMore(){
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    ApiService.getData(nextPageUrl,success: (result){
      Issue issue = Issue.fromJson(result);

      itemList.addAll(issue.itemList);
      loading = false;
      nextPageUrl = issue.nextPageUrl;
      refreshController.loadComplete();

      notifyListeners();
    },fail: (e){
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    });
  }
}

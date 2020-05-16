
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/topic_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicPageModel with ChangeNotifier{

  List<TopicItemModel> itemList = [];
  String nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  void refresh(){
    ApiService.getData(ApiService.topics_url,success: (result){
      TopicModel topicModel = TopicModel.fromJson(result);

      itemList = topicModel.itemList;
      loading = false;
      nextPageUrl = topicModel.nextPageUrl;
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
      TopicModel topicModel = TopicModel.fromJson(result);

      itemList.addAll(topicModel.itemList);
      loading = false;
      nextPageUrl = topicModel.nextPageUrl;
      refreshController.loadComplete();

      notifyListeners();
    },fail: (e){
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    });
  }

}
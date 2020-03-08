import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/search_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const SEARCH_DEFAULT_URL =
    "http://baobab.kaiyanapp.com/api/v1/search?&num=10&start=10&query=";

class VideoSearchModel extends ChangeNotifier {
  bool loading = true;
  bool hideKeyWord = false;
  bool hideEmpty = true;
  List<Item> dataList = [];
  String _nextPageUrl;
  List<String> keyWords = [];
  String query = '';
  int total = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void getKeyWords() async {
    try {
      keyWords = await SearchRepository.getKeyWordList();
      notifyListeners();
    } catch (e) {
      ToastUtil.showError(e.toString());
    }
  }

  void loadMore({loadMore = true}) {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      url = _nextPageUrl;
      getData(loadMore, url);
    } else {
      loading = true;
      url = SEARCH_DEFAULT_URL + query;
      getData(loadMore, url);
    }
  }

  void getData(bool loadMore, String url) async {
    try {
      Issue issue = await SearchRepository.getSearchVideoList(url);

      loading = false;
      total = issue.total;
      if (!loadMore) {
        dataList.clear();
        dataList.addAll(issue.itemList);
        hideEmpty = dataList.length > 0;
      } else {
        dataList.addAll(issue.itemList);
        hideEmpty = true;
      }
      _nextPageUrl = issue.nextPageUrl;
      hideKeyWord = true;

      refreshController.loadComplete();
    } catch (e) {
      ToastUtil.showError(e.toString());
      loading = false;
      refreshController.loadFailed();
    } finally {
      notifyListeners();
    }
  }
}

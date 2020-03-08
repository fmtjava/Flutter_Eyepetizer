import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/category_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const DEFAULT_URL = 'http://baobab.kaiyanapp.com/api/v4/categories/videoList?';

class CategoryDetailModel extends ChangeNotifier {
  int category;
  List<Item> itemList = [];
  String _nextPageUrl;
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  CategoryDetailModel(this.category);

  void loadMore({loadMore = true}) async {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      url = _nextPageUrl +
          "&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url);
    } else {
      url = DEFAULT_URL +
          "id=$category&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url);
    }
  }

  void getData(String url) async {
    try {
      Issue issue = await CategoryRepository.getCategoryDetailList(url);
      loading = false;
      itemList.addAll(issue.itemList);
      _nextPageUrl = issue.nextPageUrl;
      refreshController.loadComplete();
    } catch (e) {
      loading = false;
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    } finally {
      notifyListeners();
    }
  }
}

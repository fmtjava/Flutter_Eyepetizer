import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/rank_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPageModel with ChangeNotifier {
  List<Item> itemList = [];
  bool loading = true;
  String apiUrl;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(String apiUrl) {
    this.apiUrl = apiUrl;
  }

  void loadData() async {
    try {
      Issue issueModel = await RankRepository.getRankList(apiUrl);

      itemList = issueModel.itemList;
      loading = false;

      refreshController.refreshCompleted();
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
      loading = false;
    } finally {
      notifyListeners();
    }
  }
}

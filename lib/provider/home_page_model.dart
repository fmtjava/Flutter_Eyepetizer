import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//将首页的逻辑抽离到Provider中进行处理，M与V分离
class HomePageModel extends BaseChangeNotifierModel {
  List<Item> bannerList = [];
  List<Item> itemList = [];
  String nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  refresh({bool retry = false}) async {
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
          error = false;

          nextPageUrl = issueEntity.nextPageUrl;
          refreshController.refreshCompleted();
          refreshController.footerMode.value = LoadStatus.canLoading;
          await loadMore();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
          error = true;
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

  retry(){
    loading = true;
    notifyListeners();
    refresh();
  }
}

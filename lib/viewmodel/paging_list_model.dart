import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/paging_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/viewmodel/base_change_notifier_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//分页模型抽取
abstract class PagingListModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifierModel {
  List<T> itemList = []; //集合数组
  String nextPageUrl; //下一页请求链接
  bool loading = true; //是否加载中
  bool error = false; //是否加载是吧
  RefreshController refreshController = //上拉加载/下拉刷新控制器
      RefreshController(initialRefresh: false);

  //下拉刷新
  void refresh() {
    ApiService.getData(getUrl(),
        success: (json) {
          M model = getModel(json);
          doRefreshDataProcess(model.itemList);
          loading = false;
          error = false;
          nextPageUrl = getNextUrl(model);
          refreshController.refreshCompleted();
          refreshController.footerMode.value = LoadStatus.canLoading;
          doExtraAfterRefresh();
        },
        fail: (e) {
          showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
          error = true;
        },
        complete: () => notifyListeners());
  }

  //加载更多
  Future<void> loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    ApiService.getData(nextPageUrl, success: (json) {
      M model = getModel(json);
      doLoadMoreDataProcess(model.itemList);
      itemList.addAll(model.itemList);
      loading = false;
      nextPageUrl = getNextUrl(model);
      refreshController.loadComplete();

      notifyListeners();
    }, fail: (e) {
      showError(e.toString());
      refreshController.loadFailed();
    });
  }

  //错误重试
  retry() {
    loading = true;
    notifyListeners();
    refresh();
  }

  void doRefreshDataProcess(List<T> list) {
    this.itemList = list;
  }

  void doLoadMoreDataProcess(List<T> list) {}

  //下拉刷新后的额外操作
  void doExtraAfterRefresh() {}

  //下拉刷新请求地址
  String getUrl();

  //上拉加载更多请求地址
  String getNextUrl(M model) {
    return model.nextPageUrl;
  }

  //请求返回的真实数据模型
  M getModel(Map<String, dynamic> json);
}

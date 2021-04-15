import 'package:lib_core/model/paging_model.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_change_notifier_model.dart';

//分页模型抽取
abstract class PagingListModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifierModel {
  List<T> itemList = []; //集合数组
  String nextPageUrl; //下一页请求链接
  RefreshController refreshController = //上拉加载/下拉刷新控制器
      RefreshController(initialRefresh: false);

  //下拉刷新
  void refresh() {
    HttpManager.getData(getUrl(),
        success: (json) {
          M model = getModel(json);
          doRefreshDataProcess(model.itemList);
          viewState = ViewState.content;
          nextPageUrl = getNextUrl(model);
          refreshController.refreshCompleted();
          refreshController.footerMode.value = LoadStatus.canLoading;
          doExtraAfterRefresh();
        },
        fail: (e) {
          showError(e.toString());
          refreshController.refreshFailed();
          viewState = ViewState.error;
        },
        complete: () => notifyListeners());
  }

  //加载更多
  Future<void> loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    HttpManager.getData(nextPageUrl, success: (json) {
      M model = getModel(json);
      doLoadMoreDataProcess(model.itemList);
      itemList.addAll(model.itemList);
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
    viewState = ViewState.loading;
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

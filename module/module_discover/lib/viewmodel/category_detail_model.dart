import 'package:lib_core/viewmodel/base_change_notifier_model.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_discover/constant/api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryDetailModel extends BaseChangeNotifierModel {
  int category;
  List<Item> itemList = [];
  String _nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  bool expend = true;

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
      getData(url, loadMore);
    } else {
      url = URLs.categoryVideoUrl +
          "id=$category&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url, loadMore);
    }
  }

  void getData(String url, bool loadMore) {
    HttpManager.getData(url,
        success: (result) {
          Issue issue = Issue.fromJson(result);
          viewState = ViewState.content;
          if (!loadMore) error = false;
          itemList.addAll(issue.itemList);
          _nextPageUrl = issue.nextPageUrl;
          refreshController.loadComplete();
        },
        fail: (e) {
          viewState = ViewState.error;
          if (!loadMore) error = true;
          showError(e.toString());
          refreshController.loadFailed();
        },
        complete: () => notifyListeners());
  }

  retry(){
    loading = true;
    notifyListeners();
    loadMore(loadMore: false);
  }

  void changeExpendStatusByOffset(int statusBarHeight, int offset) {
    if (offset > statusBarHeight && offset < 250) {
      if (!expend) {
        expend = true;
      }
    } else {
      if (expend) {
        expend = false;
      }
    }
  }
}

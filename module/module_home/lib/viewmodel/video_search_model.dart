import 'package:lib_core/viewmodel/base_change_notifier_model.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_home/const/api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoSearchModel extends BaseChangeNotifierModel {
  bool hideKeyWord = false;
  bool hideEmpty = true;
  List<Item> dataList = [];
  String _nextPageUrl;
  List<String> keyWords = [];
  String query = '';
  int total = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  getKeyWords() {
    HttpManager.getData(URLs.keyword_url, success: (result) {
      List responseList = result as List;
      keyWords = responseList.map((value) {
        return value.toString();
      }).toList();
      notifyListeners();
    }, fail: (e) {
      showError(e.toString());
    });
  }

  loadMore({loadMore = true}) {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      url = _nextPageUrl;
      getData(loadMore, url);
    } else {
      _reset();
      url = URLs.search_url + query;
      getData(loadMore, url);
    }
  }

  getData(bool loadMore, String url) {
    HttpManager.getData(url,
        success: (result) {
          Issue issue = Issue.fromJson(result);

          viewState = ViewState.content;
          total = issue.total;
          if (!loadMore) {
            dataList.clear();
            dataList.addAll(issue.itemList);
            hideEmpty = dataList.length > 0;
          } else {
            dataList.addAll(issue.itemList);
            hideEmpty = true;
          }
          dataList.removeWhere((item) {
            return item.data.cover == null;
          });
          _nextPageUrl = issue.nextPageUrl;
          hideKeyWord = true;

          refreshController.loadComplete();
        },
        fail: (e) {
          showError(e.toString());
          if (!loadMore) viewState = ViewState.error;
          ;
          refreshController.loadFailed();
        },
        complete: () => notifyListeners());
  }

  _reset() {
    viewState = ViewState.loading;
    notifyListeners();
  }

  retry() {
    loadMore(loadMore: false);
  }
}

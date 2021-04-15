import 'package:lib_core/viewmodel/paging_list_model.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_home/const/api_service.dart';
import 'package:module_home/model/issue_model.dart';

class HomePageModel extends PagingListModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  @override
  IssueEntity getModel(Map<String, dynamic> json) => IssueEntity.fromJson(json);

  @override
  String getUrl() => URLs.feed_url;

  @override
  void doRefreshDataProcess(List<Item> list) {
    doLoadMoreDataProcess(list);
    itemList.clear();
    itemList.add(Item()); //为Banner占位
    bannerList = list;
  }

  @override
  void doLoadMoreDataProcess(List<Item> list) {
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
  }

  @override
  void doExtraAfterRefresh() async {
    await loadMore();
  }
}

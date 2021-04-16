import 'package:lib_core/viewmodel/paging_list_model.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_discover/constant/api_service.dart';

class FollowPageModel extends PagingListModel<Item,Issue>{

  @override
  String getUrl() {
    return URLs.followUrl;
  }

  @override
  Issue getModel(Map<String, dynamic> json) {
    return Issue.fromJson(json);
  }
}

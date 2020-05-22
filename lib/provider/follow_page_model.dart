import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/provider/paging_list_model.dart';

class FollowPageModel extends PagingListModel<Item,Issue>{

  @override
  String getUrl() {
    return ApiService.follow_url;
  }

  @override
  Issue getModel(Map<String, dynamic> json) {
    return Issue.fromJson(json);
  }
}

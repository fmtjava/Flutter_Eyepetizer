import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/recommend_model.dart';
import 'package:flutter_eyepetizer/provider/paging_list_model.dart';

class RecommendPageModel extends PagingListModel<RecommendItem,RecommendModel>{

  @override
  String getUrl() {
    return ApiService.community_url;
  }

  @override
  RecommendModel getModel(Map<String, dynamic> json) {
    return RecommendModel.fromJson(json);
  }
  
  @override
  void doExtraAfterRefresh() {
    itemList.removeWhere((item) {
      return item.type == 'horizontalScrollCard';
    });
  }
}

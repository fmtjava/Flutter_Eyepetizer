import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/recommend_model.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:flutter_eyepetizer/util/app_manager.dart';
import 'package:flutter_eyepetizer/util/http_constant.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendRepository extends LoadingMoreBase<RecommendItem> {
  String nextPageUrl;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    String url = '';
    if (isloadMoreAction) {
      url = nextPageUrl;
    } else {
      url = ApiService.community_url;
    }
    bool isSuccess = true;

    try {
      var response = await http.get(url, headers: HttpConstant.httpHeader);
      if (response.statusCode == 200) {
        var result =
            json.decode(AppManager.utf8decoder.convert(response.bodyBytes));
        RecommendModel model = RecommendModel.fromJson(result);
        model.itemList.removeWhere((item) {
          return item.type == 'horizontalScrollCard';
        });
        if (!isloadMoreAction) {
          clear();
        }
        addAll(model.itemList);
        nextPageUrl = model.nextPageUrl;
        _hasMore = nextPageUrl != null;
        isSuccess = true;
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      isSuccess = false;
      ToastUtil.showError(e.toString());
    }

    return isSuccess;
  }
}

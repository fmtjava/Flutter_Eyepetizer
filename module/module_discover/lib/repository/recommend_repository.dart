import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lib_utils/toast_util.dart';
import 'package:loading_more_list/loading_more_list.dart';

class RecommendRepository extends LoadingMoreBase<RecommendItem> {
  String nextPageUrl;
  bool _hasMore = true;
  bool forceRefresh = false;
  Utf8Decoder utf8decoder = Utf8Decoder();

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
      var response =
          await http.get(Uri.parse(url), headers: HttpConstant.httpHeader);
      if (response.statusCode == 200) {
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
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
      showError(e.toString());
    }

    return isSuccess;
  }
}

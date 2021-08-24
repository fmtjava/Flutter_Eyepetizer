import 'package:module_common/model/common_item_model.dart';
import 'package:lib_core/viewmodel/paging_list_model.dart';

class AuthorTabPageModel extends PagingListModel<Item, Issue> {
  String apiUrl;

  AuthorTabPageModel(this.apiUrl);

  @override
  String getUrl() {
    return apiUrl;
  }

  @override
  Issue getModel(Map<String, dynamic> json) {
    return Issue.fromJson(json);
  }
}

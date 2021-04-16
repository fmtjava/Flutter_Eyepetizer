import 'package:lib_core/viewmodel/base_change_notifier_model.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:module_discover/constant/api_service.dart';
import 'package:module_discover/model/category_model.dart';

class CategoryPageModel extends BaseChangeNotifierModel {
  List<CategoryModel> list = [];

  void loadData() async {
    HttpManager.getData(URLs.categoryUrl,
        success: (result) {
          List responseList = result as List;
          List<CategoryModel> categoryList = responseList
              .map((model) => CategoryModel.fromJson(model))
              .toList();
          this.list = categoryList;
          viewState = ViewState.content;
        },
        fail: (e) {
          showError(e.toString());
          viewState = ViewState.error;
        },
        complete: () => notifyListeners());
  }

  retry() {
    viewState = ViewState.content;
    notifyListeners();
    loadData();
  }
}

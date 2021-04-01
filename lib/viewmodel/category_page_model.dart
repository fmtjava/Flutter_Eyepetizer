import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/viewmodel/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';

class CategoryPageModel extends BaseChangeNotifierModel {
  List<CategoryModel> list = [];

  void loadData() async {
    ApiService.getData(ApiService.category_url,
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

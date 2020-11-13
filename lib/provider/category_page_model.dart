import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class CategoryPageModel extends BaseChangeNotifierModel {
  List<CategoryModel> list = [];
  bool loading = true;
  bool error = false;

  void loadData() async {
    ApiService.getData(ApiService.category_url,
        success: (result) {
          List responseList = result as List;
          List<CategoryModel> categoryList = responseList
              .map((model) => CategoryModel.fromJson(model))
              .toList();
          this.list = categoryList;
          loading = false;
          error = false;
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          loading = false;
          error = true;
        },
        complete: () => notifyListeners());
  }
  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}

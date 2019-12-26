import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/repository/category_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class CategoryPageModel with ChangeNotifier {

  List<CategoryModel> list = [];
  bool loading = true;

  void loadData() async {
    try {
      List<CategoryModel> list = await CategoryRepository.getCategoryList();
      this.list = list;
      loading = false;
    } catch (e) {
      ToastUtil.showError(e.toString());
      loading = false;
    } finally {
      notifyListeners();
    }
  }
}

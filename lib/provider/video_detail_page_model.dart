import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/video_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class VideoDetailPageModel with ChangeNotifier {
  List<Item> itemList = [];
  bool loading = true;

  void loadVideoRelateData(int id) async {
    try {
      Issue issue = await VideoRepository.getVideoRelateList(id);
      itemList = issue.itemList;
      loading = false;
    } catch (e) {
      ToastUtil.showError(e.toString());
      loading = false;
    } finally {
      notifyListeners();
    }
  }
}

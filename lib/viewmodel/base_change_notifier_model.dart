
import 'package:flutter/material.dart';

class BaseChangeNotifierModel with ChangeNotifier{

  bool _dispose = false;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    //防止页面销毁后，网络数据请求回来后调用notifyListeners方法，_debugAssertNotDisposed()报错问题
    //另一种方案在页面销毁时取消网络请求
    if(!_dispose){
      super.notifyListeners();
    }
  }
}
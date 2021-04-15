import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    //判断是否渲染完成，防止数据还没有获取到，此时setState触发的控件渲染就会报错
    if (mounted) {
      super.setState(fn);
    }
  }
}

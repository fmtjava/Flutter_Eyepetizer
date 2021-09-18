library lib_navigator;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'package:get/get.dart';

//页面路由常用方法封装

void toPage(Widget page, {bool opaque = false, preventDuplicates: true}) {
  Get.to(() => page, opaque: opaque, preventDuplicates: preventDuplicates);
}

void offPage(Widget page, {bool opaque = false}) {
  Get.off(() => page, opaque: opaque);
}

void toNamed(String page, dynamic arguments, {preventDuplicates: false}) {
  Get.toNamed(page, preventDuplicates: preventDuplicates, arguments: arguments);
}

void offNamed(String page, dynamic arguments, {preventDuplicates: false}) {
  Get.offNamed(page,
      preventDuplicates: preventDuplicates, arguments: arguments);
}

void offAndToNamed(String page, dynamic arguments) {
  Get.offAndToNamed(page, arguments: arguments);
}

void back() {
  Get.back();
}

//获取页面传递的参数
dynamic arguments() {
  return Get.arguments;
}

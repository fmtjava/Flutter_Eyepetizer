library lib_navigator;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'package:get/get.dart';

void toPage(Widget page, {bool opaque = false}) {
  Get.to(() => page, opaque: opaque);
}

void toNamed(String page, dynamic arguments) {
  Get.toNamed(page, arguments: arguments);
}

void back() {
  Get.back();
}

dynamic arguments() {
  return Get.arguments;
}

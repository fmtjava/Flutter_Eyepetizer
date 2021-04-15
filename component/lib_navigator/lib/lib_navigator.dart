library lib_navigator;

export 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void toPage(Widget page, {bool opaque = false}) {
  Get.to(() => page, opaque: opaque);
}

void back() {
  Get.back();
}

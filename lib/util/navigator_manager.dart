import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorManager {
  static to(Widget page, {bool opaque = false}) {
    Get.to(page, opaque: opaque);
  }

  static back() {
    Get.back();
  }
}

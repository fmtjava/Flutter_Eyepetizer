import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorManager {
  static to(Widget page, {bool rebuildRoutes = false}) {
    Get.to(page, rebuildRoutes: rebuildRoutes);
  }

  static back() {
    Get.back();
  }
}

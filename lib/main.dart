import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/navigation/tab_navigation.dart';
import 'package:flutter_eyepetizer/util/app_manager.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
  //Flutter沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    hideSplashScreen();
    AppManager.init();
    return MaterialApp(
        title: 'Eyepetizer', navigatorKey: Get.key, home: TabNavigation());
  }

  Future<void> hideSplashScreen() async {
    Future.delayed(
        Duration(milliseconds: 2000), () => FlutterSplashScreen.hide());
  }
}

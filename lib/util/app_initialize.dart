import 'dart:convert';
import 'package:flutter_eyepetizer/db/CacheManager.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class AppInitialize {
  AppInitialize._();

  static Utf8Decoder utf8decoder = Utf8Decoder();

  //App初始化工作
  static Future<void> init() async {
    await CacheManager.preInit();
    Future.delayed(
        Duration(milliseconds: 2000), () => FlutterSplashScreen.hide());
  }
}

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lib_cache/cache_manager.dart';
import 'package:module_common/constant/http_constant.dart';

class AppInitialize {
  AppInitialize._();

  //App初始化工作
  static Future<void> init() async {
    await CacheManager.preInit();
    HttpConstant.baseUrl = 'http://baobab.kaiyanapp.com/api/';
    Future.delayed(
        Duration(milliseconds: 2000), () => FlutterNativeSplash.remove());
  }
}

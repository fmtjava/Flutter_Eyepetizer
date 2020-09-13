import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  AppManager._();

  static Utf8Decoder utf8decoder = Utf8Decoder();
  static SharedPreferences prefs;

  //App初始化工作
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

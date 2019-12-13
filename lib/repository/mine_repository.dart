import 'dart:io';

import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineRepository {
  static Future<String> getAvatarPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.userAvatarPath);
  }

  static saveAvatarPath(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.userAvatarPath, file.path);
  }
}

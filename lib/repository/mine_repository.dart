import 'dart:io';

import 'package:flutter_eyepetizer/db/CacheManager.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class MineRepository {
  static String getAvatarPath() {
    return CacheManager.getInstance().get<String>(Constant.userAvatarPath);
  }

  static saveAvatarPath(File file) async {
    CacheManager.getInstance().set(Constant.userAvatarPath, file.path);
  }
}

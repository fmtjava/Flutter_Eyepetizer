import 'dart:io';

import 'package:flutter_eyepetizer/constant/constant.dart';
import 'package:lib_cache/cache_manager.dart';

class MineRepository {
  static String getAvatarPath() {
    return CacheManager.getInstance().get<String>(Constant.userAvatarPath);
  }

  static saveAvatarPath(File file) async {
    CacheManager.getInstance().set(Constant.userAvatarPath, file.path);
  }
}

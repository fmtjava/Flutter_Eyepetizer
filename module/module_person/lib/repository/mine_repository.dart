import 'dart:io';

import 'package:lib_cache/cache_manager.dart';

class MineRepository {
  static const String user_avatar_path = "user_avatar_path";

  static String? getAvatarPath() {
    return CacheManager.getInstance().get<String?>(user_avatar_path);
  }

  static saveAvatarPath(File file) async {
    CacheManager.getInstance().set(user_avatar_path, file.path);
  }
}

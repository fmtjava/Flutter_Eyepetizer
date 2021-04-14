import 'package:shared_preferences/shared_preferences.dart';

///本地缓存管理类
class CacheManager {
  SharedPreferences _preferences;

  CacheManager._();

  CacheManager._pre(SharedPreferences preferences) {
    this._preferences = preferences;
  }

  static CacheManager _instance;

  static CacheManager getInstance() {
    if (_instance == null) {
      _instance = CacheManager._();
    }
    return _instance;
  }

  //预初始化，防止get时，SharedPreferences还未初始化完毕
  static Future<CacheManager> preInit() async {
    if (_instance == null) {
      var preferences = await SharedPreferences.getInstance();
      _instance = CacheManager._pre(preferences);
    }
    return _instance;
  }

  set(String key, Object value) {
    if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      throw Exception("only Support int、String、double、bool、List<String>");
    }
  }

  T get<T>(String key) {
    return _preferences.get(key);
  }
}

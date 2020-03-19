
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppManager{

  static Utf8Decoder utf8decoder = Utf8Decoder();
  static SharedPreferences prefs;

  static init() async{
    prefs = await SharedPreferences.getInstance();
  }

}
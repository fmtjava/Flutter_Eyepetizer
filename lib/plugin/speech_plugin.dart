import 'package:flutter/services.dart';

class SpeechPlugin {
  //定义与Native进行交互的MethodChannel,Android与Ios通用
  static const MethodChannel _methodChannel = MethodChannel('speech_plugin');

  static Future<String> start() async {
    return await _methodChannel.invokeMethod('start');
  }
}

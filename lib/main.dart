import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/navigation/tab_navigation.dart';
import 'package:flutter_eyepetizer/app_initialize.dart';
import 'package:lib_navigator/lib_navigator.dart';

void main() {
  runApp(App());
  //Flutter沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    //使用FutureBuilder进行异步初始化
    return FutureBuilder<void>(
      future: AppInitialize.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? TabNavigation()
            : Scaffold(
                body: CircularProgressIndicator(),
              );

        return MaterialApp(
            title: 'Eyepetizer', navigatorKey: Get.key, home: widget);
      },
    );
  }
}

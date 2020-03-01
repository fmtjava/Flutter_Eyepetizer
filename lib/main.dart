import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/navigation/tab_navigation.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

void main() {
  runApp(App());
  //Flutter沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    hideSplashScreen();
    return MaterialApp(title: '开眼', home: TabNavigation());
  }

  Future<void> hideSplashScreen() async {
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }
}

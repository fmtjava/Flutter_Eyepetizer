import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/navigation/tab_navigation.dart';
import 'package:flutter_eyepetizer/app_initialize.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_detail/page/video_detail_page.dart';
import 'package:module_author/page/author_page.dart';

void main() {
  runApp(App());
  //Flutter沉浸式状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: AppInitialize.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? TabNavigation()
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return GetMaterialAppWidget(
          child: widget,
        );
      },
    );
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  final Widget child;

  const GetMaterialAppWidget({Key key, this.child}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eyepetizer',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => widget.child),
        GetPage(name: '/detail', page: () => VideoDetailPage()),
        GetPage(name: '/author', page: () => AuthorPage()),
      ],
    );
  }
}

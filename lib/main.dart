import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_eyepetizer/navigation/tab_navigation.dart';
import 'package:flutter_eyepetizer/app_initialize.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_detail/page/video_detail_page.dart';
import 'package:module_author/page/author_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eyepetizer',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => GetMaterialAppWidget()),
        GetPage(name: '/detail', page: () => VideoDetailPage()),
        GetPage(name: '/author', page: () => AuthorPage()),
      ],
    );
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  const GetMaterialAppWidget({Key? key}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: AppInitialize.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? TabNavigation()
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}

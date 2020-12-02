import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget {
  final String url;

  const WebPage({Key key, this.url}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WebPage> {
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();
  String currentUrl = '';

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      currentUrl = url;
    });
    flutterWebViewPlugin.onStateChanged.listen((event) {
      if (event.type == WebViewState.finishLoad) {
        String js = "javascript:(function() {document.getElementsByClassName(\"share-bar-container\")[0].style.display=\'none\';" +
            "document.getElementsByClassName(\"footer-container j-footer-container\")[0].style.display=\'none\';" +
            "document.getElementsByClassName(\"kyt-promotion-bar-positioner\")[0].style.display=\'none\';" +
            "})()";
        flutterWebViewPlugin.evalJavascript(js);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      "/": (_) => WillPopScope(
          //处理返回键事件
          child: WebviewScaffold(
              url: widget.url,
              appBar: _appBar(),
              withZoom: true,
              withJavascript: true,
              hidden: true,
              scrollBar: false,
              //默认隐藏WebView
              initialChild: Container(
                child: Center(child: CircularProgressIndicator()),
              )),
          // ignore: missing_return
          onWillPop: _onWillPop),
    });
  }

  Widget _appBar() {
    return AppBar(
        leading: GestureDetector(
          onTap: () {
            if (widget.url == currentUrl || currentUrl.isEmpty) {
              NavigatorManager.back();
            } else {
              flutterWebViewPlugin.goBack();
            }
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),
        title: new Text(
          DString.news_title,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light);
  }

  Future<bool> _onWillPop() {
    if (widget.url == currentUrl) {
      NavigatorManager.back();
      return Future.value(true); //点击返回键，页面正常返回
    } else {
      flutterWebViewPlugin.goBack();
      return Future.value(false); //点击返回键，页面不能返回
    }
  }
}

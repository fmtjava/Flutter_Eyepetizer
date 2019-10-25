import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "/": (_) => WillPopScope(
            //处理返回键事件
            child: WebviewScaffold(
                url: widget.url,
                appBar: _appBar(),
                withZoom: true,
                withJavascript: true,
                hidden: true,
                //默认隐藏WebView
                initialChild: Container(
                  child: Center(child: CircularProgressIndicator()),
                )),
            // ignore: missing_return
            onWillPop: _onWillPop),
      },
    );
  }

  Widget _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          if (widget.url == currentUrl) {
            Navigator.pop(context);
          } else {
            flutterWebViewPlugin.goBack();
          }
        },
        child: Icon(Icons.arrow_back, size: 25),
      ),
      title: new Text("个人主页"),
      backgroundColor: Color(0xff25292d),
    );
  }

  Future<bool> _onWillPop() {
    if (widget.url == currentUrl) {
      Navigator.pop(context);
      return new Future.value(true); //点击返回键，页面正常返回
    } else {
      flutterWebViewPlugin.goBack();
      return new Future.value(false); //点击返回键，页面不能返回
    }
  }
}

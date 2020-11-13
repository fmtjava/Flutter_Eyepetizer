import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/plugin/speech_plugin.dart';
import 'package:flutter_eyepetizer/provider/video_search_model.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/search_video_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SafeArea(
                child: ProviderWidget<VideoSearchModel>(
                    model: VideoSearchModel(),
                    onModelInit: (model) => model.getKeyWords(),
                    builder: (context, model, child) {
                      return Column(children: <Widget>[
                        _searchBar(model, context),
                        Expanded(
                            flex: 1,
                            child: Stack(children: <Widget>[
                              _keyWordWidget(model),
                              _searchVideoWidget(model),
                              _emptyWidget(model)
                            ]))
                      ]);
                    }))));
  }

  Widget _searchBar(VideoSearchModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 16),
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black26,
              ),
              onPressed: () => NavigatorManager.back()),
          Expanded(
              child: ConstrainedBox(
                  //通过ConstrainedBox修改TextField的高度
                  constraints: BoxConstraints(maxHeight: 30),
                  child: TextField(
                    autofocus: true,
                    onSubmitted: (value) {
                      model.query = value;
                      model.loadMore(loadMore: false);
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 15),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black26,
                        ),
                        fillColor: Color(0x0D000000),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: DString.interest_video,
                        hintStyle: TextStyle(fontSize: 13)),
                  ))),
          Offstage(
            offstage: !Platform.isAndroid,
            child: IconButton(
                icon: Icon(Icons.keyboard_voice, color: Colors.black26),
                onPressed: () {
                  _showSpeechDialog(model);
                }),
          )
        ],
      ),
    );
  }

  Widget _keyWordWidget(VideoSearchModel model) {
    return Offstage(
        offstage: model.hideKeyWord,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Center(
              child: Text(
                DString.hot_key_word,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 10,
                children: _keyWordWidgets(model)),
          )
        ]));
  }

  List<Widget> _keyWordWidgets(VideoSearchModel model) {
    return model.keyWords.map((keyword) {
      return GestureDetector(
          onTap: () {
            _hideTextInput();
            model.query = keyword;
            model.loadMore(loadMore: false);
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
              decoration: BoxDecoration(
                color: Color(0x1A000000),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                keyword,
                style: TextStyle(fontSize: 12, color: Colors.black45),
              )));
    }).toList();
  }

  Widget _searchVideoWidget(VideoSearchModel model) {
    return Offstage(
        offstage: model.dataList == null || model.dataList.length == 0,
        child: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('— 「${model.query}」搜索结果共${model.total}个 —',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ))),
              Expanded(
                  flex: 1,
                  child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: model.loadMore,
                      controller: model.refreshController,
                      child: ListView.builder(
                          itemCount: model.dataList.length,
                          itemBuilder: (context, index) {
                            return SearchVideoWidgetItem(
                                item: model.dataList[index]);
                          })))
            ])));
  }

  Widget _emptyWidget(VideoSearchModel model) {
    return Offstage(
        offstage: model.hideEmpty,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Icon(Icons.sentiment_dissatisfied,
                  size: 60, color: Colors.black54),
              Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    DString.no_data,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ))
            ])));
  }

  _showSpeechDialog(VideoSearchModel model) {
    SpeechPlugin.start().then((result) {
      if (result.isNotEmpty) {
        _hideTextInput();
        model.query = result;
        model.loadMore(loadMore: false);
      }
    });
  }

  _hideTextInput() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

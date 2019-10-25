import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/widget/video_relate_widget_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchHistoryPage extends StatefulWidget {
  @override
  _WatchHistoryPageState createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  List<Item> _itemList;
  List<String> _watchList;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
          title: Text(
            '观看记录',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0),
      body: Stack(
        children: <Widget>[
          Offstage(
              offstage: _itemList == null || _itemList.length == 0,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Dismissible(//滑动删除控件
                      //列表侧滑删除'
                      key: Key(_itemList[index].toString()),
                      child: VideoRelateWidgetItem(
                        item: _itemList[index],
                        callBack: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  VideoDetailPage(item: _itemList[index])));
                        },
                        titleColor: Colors.black87,
                        categoryColor: Colors.black26,
                      ),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (direction) {//滑动删除事件
                        _remove(index);
                        setState(() {
                          _itemList.removeAt(index);
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 0.5);
                  },
                  itemCount: _itemList?.length ?? 0)),
          Offstage(
            //控制控件显示或隐藏
            offstage: _itemList != null && _itemList.length > 0,
            child: Center(
              child: Image.asset('images/ic_no_data.png'),
            ),
          )
        ],
      ),
    );
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _watchList = prefs.getStringList("watch_history_list");
    if (_watchList != null && _watchList.length > 0) {
      setState(() {
        _itemList = _watchList.map((value) {
          var jsonStr = json.decode(value);
          return Item.fromJson(jsonStr);
        }).toList();
      });
    }
  }

  void _remove(int index) async {
    _watchList.removeAt(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('watch_history_list', _watchList);
  }
}

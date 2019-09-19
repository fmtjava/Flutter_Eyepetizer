import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/page/watch_history_page.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 44,
              backgroundImage: AssetImage('images/ic_img_avatar.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'fmtjava',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '查看个人主页 >',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _operateWidget('images/icon_like_grey.png', '收藏'),
                Container(
                  width: 0.5,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                _operateWidget('images/icon_comment_grey.png', '评论'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              height: 0.5,
              decoration: BoxDecoration(color: Colors.grey),
            ),
          ),
          _settingWidget('我的消息'),
          _settingWidget('我的记录'),
          _settingWidget('我的缓存'),
          _settingWidget('观看记录', callback: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WatchHistoryPage()));
          }),
          _settingWidget('意见反馈')
        ],
      )),
    );
  }

  Widget _operateWidget(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(image, width: 20, height: 20),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        )
      ],
    );
  }

  Widget _settingWidget(String text, {VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}

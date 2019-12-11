import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/page/watch_history_page.dart';
import 'package:flutter_eyepetizer/page/web_page.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_INFO_URL = 'https://github.com/fmtjava/';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    _getAvatarPath();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
          child: Column(
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 44,
                backgroundImage: _imageFile == null
                    ? AssetImage('images/ic_img_avatar.png')
                    : FileImage(_imageFile),
              ),
            ),
            onTap: () {
              _showSelectPhotoDialog(context);
            },
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
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebPage(url: USER_INFO_URL)));
                  },
                  child: Text(
                    '查看个人主页 >',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ))),
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

  var _imageFile;

  _showSelectPhotoDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  title: Text('拍照', textAlign: TextAlign.center),
                  onTap: () async {
                    Navigator.pop(context);
                    _getImage(ImageSource.camera);
                  }),
              ListTile(
                  title: Text('相册', textAlign: TextAlign.center),
                  onTap: () async {
                    Navigator.pop(context);
                    _getImage(ImageSource.gallery);
                  }),
              ListTile(
                  title: Text('取消', textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
  //模拟头像选择修改，目前存储在本地，实际开发应当上传到云存储平台
  Future _getImage(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = imageFile;
    });
    _saveAvatarPath(imageFile);
  }

  _saveAvatarPath(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.userAvatarPath, file.path);
  }

  _getAvatarPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAvatarPath = prefs.getString(Constant.userAvatarPath);
    if (userAvatarPath != null && userAvatarPath.isNotEmpty) {
      setState(() {
        _imageFile = File(userAvatarPath);
      });
    }
  }
}

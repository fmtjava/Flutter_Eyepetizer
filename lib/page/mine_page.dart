import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/page/watch_history_page.dart';
import 'package:flutter_eyepetizer/repository/mine_repository.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:image_picker/image_picker.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  var _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getAvatarPath();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      //Flutter修改状态栏字体颜色
      value: SystemUiOverlayStyle.dark, //设置状态栏字体颜色
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
            //适配刘海屏
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
                child: Text(
                  '查看个人主页 >',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )),
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
              NavigatorManager.to(WatchHistoryPage());
            }),
            _settingWidget('意见反馈')
          ],
        )),
      ),
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

  _showSelectPhotoDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _bottomWidget('拍照', () {
                NavigatorManager.back();
                _getImage(ImageSource.camera);
              }),
              _bottomWidget('相册', () {
                NavigatorManager.back();
                _getImage(ImageSource.gallery);
              }),
              _bottomWidget('取消', () {
                NavigatorManager.back();
              })
            ],
          );
        });
  }

  Widget _bottomWidget(String text, VoidCallback callback) {
    return ListTile(
        title: Text(text, textAlign: TextAlign.center), onTap: callback);
  }

  //模拟头像选择修改，目前存储在本地，实际开发应当上传到云存储平台
  _getImage(ImageSource source) async {
    var imageFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = File(imageFile.path);
    });
    MineRepository.saveAvatarPath(_imageFile);
  }

  _getAvatarPath() async {
    var userAvatarPath = await MineRepository.getAvatarPath();
    if (userAvatarPath != null && userAvatarPath.isNotEmpty) {
      setState(() {
        _imageFile = File(userAvatarPath);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

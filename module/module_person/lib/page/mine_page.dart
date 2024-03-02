import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:lib_ui/widget/blur_widget.dart';
import 'package:module_person/page/watch_history_page.dart';
import 'package:module_person/repository/mine_repository.dart';

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
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: <Widget>[
          headWidget,
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
          ..._settingListWidget()
        ],
      ),
    );
  }

  Widget get headWidget {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image(
            image: avatarImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
            child: BlurWidget(
          sigma: 20,
          color: Colors.white.withOpacity(0.0),
        )),
        Column(
          children: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 45),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 44,
                  backgroundImage: avatarImage,
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
                  style: TextStyle(fontSize: 12, color: Colors.black26),
                )),
          ],
        )
      ],
    );
  }

  ImageProvider get avatarImage {
    return (_imageFile == null
        ? AssetImage('images/ic_img_avatar.png', package: 'module_person')
        : FileImage(_imageFile)) as ImageProvider;
  }

  Widget _operateWidget(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(image, width: 20, height: 20, package: 'module_person'),
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

  _settingListWidget() {
    return [
      _settingWidget('我的消息'),
      _settingWidget('我的记录'),
      _settingWidget('我的缓存'),
      _settingWidget('观看记录', callback: () {
        toPage(WatchHistoryPage());
      }),
      _settingWidget('意见反馈')
    ];
  }

  Widget _settingWidget(String text, {VoidCallback? callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
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
            children: <Widget>[..._bottomListWidget()],
          );
        });
  }

  _bottomListWidget() {
    return [
      _bottomWidget('拍照', () {
        back();
        _getImage(ImageSource.camera);
      }),
      _bottomWidget('相册', () {
        back();
        _getImage(ImageSource.gallery);
      }),
      _bottomWidget('取消', () {
        back();
      })
    ];
  }

  Widget _bottomWidget(String text, VoidCallback callback) {
    return ListTile(
        title: Text(text, textAlign: TextAlign.center), onTap: callback);
  }

  //模拟头像选择修改，目前存储在本地，实际开发应当上传到云存储平台
  _getImage(ImageSource source) async {
    var imageFile = await picker.pickImage(source: source);
    setState(() {
      _imageFile = File(imageFile?.path ?? '');
    });
    MineRepository.saveAvatarPath(_imageFile);
  }

  _getAvatarPath() {
    var userAvatarPath = MineRepository.getAvatarPath();
    if (userAvatarPath != null && userAvatarPath.isNotEmpty) {
      setState(() {
        _imageFile = File(userAvatarPath);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

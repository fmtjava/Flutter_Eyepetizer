import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/util/view_util.dart';

appBar(String title, {bool showBack = true, List<Widget> actions}) {
  return AppBar(
    title: Text(title,
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
    brightness: Brightness.light,
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: showBack
        ? BackButton(
            color: Colors.black,
          )
        : null,
    actions: actions,
  );
}

///视频详情页appBar
videoAppBar() {
  return Container(
    padding: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.transparent,
          child: BackButton(
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
          ],
        )
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:lib_utils/view_util.dart';

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

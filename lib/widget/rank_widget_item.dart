import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';

class RankWidgetItem extends StatelessWidget {
  final Item item;
  final bool showCategory;

  const RankWidgetItem({Key key, this.item, this.showCategory = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VideoDetailPage(item: item)));
          },
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  height: 225,
                  imageUrl: item.data.cover.feed,
                  errorWidget: (context, url, error) =>
                      Image.asset('images/img_load_fail.png'),
                  fit: BoxFit.cover),
              Positioned(
                  left: 15,
                  top: 10,
                  child: Opacity(
                      opacity: showCategory ? 1.0 : 0.0, //处理控件显示或隐藏
                      child: ClipOval(
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white54),
                              height: 44,
                              width: 44,
                              alignment: AlignmentDirectional.center,
                              child: Text(item.data.category,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))))),
              Positioned(
                  right: 15,
                  bottom: 10,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                          decoration: BoxDecoration(color: Colors.black54),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            DateUtil.formatDateMs(item.data.duration * 1000,
                                format: 'mm:ss'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ))))
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            children: <Widget>[
              ClipOval(
                  child: CachedNetworkImage(
                width: 44,
                height: 44,
                imageUrl: item.data.author.icon,
              )),
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.data.title,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                          Text(item.data.author.name,
                              style: TextStyle(
                                  color: Color(0xff9a9a9a), fontSize: 12))
                        ],
                      ))),
              Image.asset(
                'images/icon_share.png',
                width: 30,
                height: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}

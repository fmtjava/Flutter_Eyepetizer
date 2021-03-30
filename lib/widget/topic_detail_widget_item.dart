import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/color.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/util/date_util.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:flutter_eyepetizer/util/share_util.dart';
import 'package:flutter_eyepetizer/util/view_util.dart';

class TopicDetailWidgetItem extends StatelessWidget {
  final TopicDetailItemData model;

  const TopicDetailWidgetItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => toPage(VideoDetailPage(data: model.data.content.data)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headWidget(),
            _desWidget(),
            _tagWidget(),
            _feedWidget(context),
            _consumptionWidget(),
            _dividerWidget()
          ],
        ));
  }

  Widget _headWidget() {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
            child: ClipOval(
                child: cacheImage(
              model.data.header.icon == null ? '' : model.data.header.icon,
              width: 45,
              height: 45,
            ))),
        Expanded(
            child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.data.header.issuerName == null
                    ? ''
                    : model.data.header.issuerName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${formatDateMsByYMD(model.data.header.time)}发布：',
                    style: TextStyle(color: DColor.hitTextColor, fontSize: 12),
                  ),
                  Expanded(
                      child: Text(
                    model.data.content.data.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))
                ],
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _desWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(
        model.data.content.data.description,
        style: TextStyle(fontSize: 14, color: DColor.desTextColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _tagWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: _getTagWidgetList(model),
      ),
    );
  }

  Widget _feedWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              child: Hero(
                  tag:
                      '${model.data.content.data.id}${model.data.content.data.time}',
                  child: cacheImage(
                    model.data.content.data.cover.feed,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  )), //充满容器，可能会被截断
              borderRadius: BorderRadius.circular(4)),
          Positioned(
              right: 8,
              bottom: 8,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.black54),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        formatDateMsByMS(
                            model.data.content.data.duration * 1000),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ))))
        ],
      ),
    );
  }

  Widget _consumptionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.favorite_border, size: 20, color: DColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  '${model.data.content.data.consumption.collectionCount}',
                  style: TextStyle(fontSize: 12, color: DColor.hitTextColor)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.message, size: 20, color: DColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('${model.data.content.data.consumption.replyCount}',
                  style: TextStyle(fontSize: 12, color: DColor.hitTextColor)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star_border, size: 20, color: DColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(DString.collect_text,
                  style: TextStyle(fontSize: 12, color: DColor.hitTextColor)),
            )
          ],
        ),
        IconButton(
            icon: Icon(Icons.share, color: DColor.hitTextColor),
            onPressed: () => share(model.data.content.data.title,
                model.data.content.data.webUrl.forWeibo))
      ],
    );
  }

  Widget _dividerWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Divider(
        height: 0.5,
      ),
    );
  }

  List<Widget> _getTagWidgetList(TopicDetailItemData itemData) {
    List<Widget> widgetList = itemData.data.content.data.tags.map((tag) {
      return Container(
          margin: EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          height: 20,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: DColor.tabBgColor, borderRadius: BorderRadius.circular(4)),
          child: Text(
            tag.name,
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ));
    }).toList();
    return widgetList.length > 3 ? widgetList.sublist(0, 3) : widgetList;
  }
}

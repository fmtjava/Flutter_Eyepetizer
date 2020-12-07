import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/color.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/util/date_util.dart';
import 'package:flutter_eyepetizer/util/share_util.dart';
import 'package:flutter_eyepetizer/widget/feed_video_widget.dart';

class TopicDetailWidgetItem extends StatefulWidget {
  final TopicDetailItemData model;
  final ValueNotifier<double> scrollNotifier;
  final ValueNotifier<int> playNotifier;
  final int index;
  final double aspectRatio;

  const TopicDetailWidgetItem(
      {Key key,
      this.model,
      this.scrollNotifier,
      this.playNotifier,
      this.index,
      this.aspectRatio})
      : super(key: key);

  @override
  _TopicDetailWidgetItemState createState() => _TopicDetailWidgetItemState();
}

class _TopicDetailWidgetItemState extends State<TopicDetailWidgetItem> {
  GlobalKey _listGlobalKey = GlobalKey();
  GlobalKey<FeedVideoWidgetState> _feedVideoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _feedVideoKey.currentState.go2VideoDetailPage();
      },
      child: Column(
        key: _listGlobalKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headWidget(widget.model),
          _desWidget(widget.model),
          _tagWidget(widget.model),
          FeedVideoWidget(
              key: _feedVideoKey,
              model: widget.model,
              scrollNotifier: widget.scrollNotifier,
              playNotifier: widget.playNotifier,
              index: widget.index,
              aspectRatio: widget.aspectRatio,
              listGlobalKey: _listGlobalKey),
          _consumptionWidget(widget.model),
        ],
      ),
    );
  }

  Widget _headWidget(TopicDetailItemData model) {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
            child: ClipOval(
                child: CachedNetworkImage(
              width: 45,
              height: 45,
              imageUrl:
                  model.data.header.icon == null ? '' : model.data.header.icon,
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
                    '${DateUtils.formatDateMsByYMD(model.data.header.time)}发布：',
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

  Widget _desWidget(TopicDetailItemData model) {
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

  Widget _tagWidget(TopicDetailItemData model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: _getTagWidgetList(model),
      ),
    );
  }

  Widget _consumptionWidget(TopicDetailItemData model) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.favorite_border,
                    size: 20, color: DColor.hitTextColor),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                      '${model.data.content.data.consumption.collectionCount}',
                      style:
                          TextStyle(fontSize: 12, color: DColor.hitTextColor)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.message, size: 20, color: DColor.hitTextColor),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                      '${model.data.content.data.consumption.replyCount}',
                      style:
                          TextStyle(fontSize: 12, color: DColor.hitTextColor)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.star_border, size: 20, color: DColor.hitTextColor),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(DString.collect_text,
                      style:
                          TextStyle(fontSize: 12, color: DColor.hitTextColor)),
                )
              ],
            ),
            IconButton(
                icon: Icon(Icons.share, color: DColor.hitTextColor),
                onPressed: () => ShareUtil.share(model.data.content.data.title,
                    model.data.content.data.webUrl.forWeibo))
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Divider(
            height: 0.5,
          ),
        )
      ],
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

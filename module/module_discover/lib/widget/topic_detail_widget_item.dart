import 'package:flutter/material.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_ui/widget/remod_more_text_widget.dart';
import 'package:lib_utils/date_util.dart';
import 'package:lib_utils/share_util.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_common/constant/color.dart';
import 'package:module_discover/constant/color.dart';
import 'package:module_discover/constant/string.dart';
import 'package:module_discover/model/topic_detail_model.dart';

class TopicDetailWidgetItem extends StatelessWidget {
  final TopicDetailItemData? model;

  const TopicDetailWidgetItem({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => toNamed('/detail', model?.data?.content?.data),
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
              (model?.data?.header?.icon == null
                      ? ''
                      : model?.data?.header?.icon) ??
                  '',
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
                '${model?.data?.header?.issuerName == null ? '' : model?.data?.header?.issuerName}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${formatDateMsByYMD(model?.data?.header?.time ?? 0)}发布：',
                    style: TextStyle(color: hitTextColor, fontSize: 12),
                  ),
                  Expanded(
                      child: Text(
                    model?.data?.content?.data?.title ?? '',
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
    var textStyle = const TextStyle(
        fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold);
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: ReadMoreTextWidget(
          model?.data?.content?.data?.description ?? '',
          style: TextStyle(fontSize: 14, color: desTextColor),
          moreStyle: textStyle,
          lessStyle: textStyle,
        ));
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
                      '${model?.data?.content?.data?.id}${model?.data?.content?.data?.time}',
                  child: cacheImage(
                    model?.data?.content?.data?.cover?.feed ?? '',
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
                            model?.data?.content?.data?.duration ?? 0 * 1000),
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
            Icon(Icons.favorite_border, size: 20, color: hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  '${model?.data?.content?.data?.consumption?.collectionCount}',
                  style: TextStyle(fontSize: 12, color: hitTextColor)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.message, size: 20, color: hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  '${model?.data?.content?.data?.consumption?.replyCount}',
                  style: TextStyle(fontSize: 12, color: hitTextColor)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star_border, size: 20, color: hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(collect_text,
                  style: TextStyle(fontSize: 12, color: hitTextColor)),
            )
          ],
        ),
        IconButton(
            icon: Icon(Icons.share, color: hitTextColor),
            onPressed: () => share(model?.data?.content?.data?.title ?? '',
                model?.data?.content?.data?.webUrl?.forWeibo ?? ''))
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

  List<Widget> _getTagWidgetList(TopicDetailItemData? itemData) {
    List<Widget>? widgetList = itemData?.data?.content?.data?.tags?.map((tag) {
      return Container(
          margin: EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          height: 20,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: tabBgColor, borderRadius: BorderRadius.circular(4)),
          child: Text(
            tag.name ?? '',
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ));
    }).toList();
    return (widgetList != null && widgetList.length > 3)
        ? widgetList!.sublist(0, 3)
        : widgetList!;
  }
}

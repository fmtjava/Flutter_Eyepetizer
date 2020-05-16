import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/topic_model.dart';
import 'package:flutter_eyepetizer/page/topics_detail_page.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';

class TopicWidgetItem extends StatelessWidget {
  final TopicItemModel itemModel;

  const TopicWidgetItem({Key key, this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            NavigatorManager.to(TopicDetailPage(detailId: itemModel.data.id)),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                    child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        imageUrl: itemModel.data.image,
                        errorWidget: (context, url, error) =>
                            Image.asset('images/img_load_fail.png'),
                        fit: BoxFit.cover), //充满容器，可能会被截断
                    borderRadius: BorderRadius.circular(4))),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Divider(height: 0.5))
          ],
        ));
  }
}

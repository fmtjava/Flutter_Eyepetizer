import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/topic_model.dart';

class TopicWidgetItem extends StatelessWidget {
  final TopicItemModel itemModel;

  const TopicWidgetItem({Key key, this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

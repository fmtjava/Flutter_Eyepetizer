import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';

class VideoRelateWidgetItem extends StatelessWidget {
  final Item item;
  final VoidCallback callBack;
  final Color titleColor;
  final Color categoryColor;

  const VideoRelateWidgetItem(
      {Key key,
      this.item,
      this.callBack,
      this.titleColor = Colors.white,
      this.categoryColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callBack();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                        imageUrl: item.data.cover.detail,
                        errorWidget: (context, url, error) =>
                            Image.asset('images/img_load_fail.png'),
                        width: 135,
                        height: 80,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                      right: 5,
                      bottom: 5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.black54),
                              padding: EdgeInsets.all(3),
                              child: Text(
                                DateUtil.formatDateMs(item.data.duration * 1000,
                                    format: 'mm:ss'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ))))
                ],
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.data.title,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                              '#${item.data.category} / ${item.data.author?.name}',
                              style: TextStyle(
                                color: categoryColor,
                                fontSize: 12,
                              )),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}

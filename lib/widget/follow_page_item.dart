import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'follow_widget_item.dart';

class FollowPageItem extends StatelessWidget {
  final Item item;

  const FollowPageItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              children: <Widget>[
                ClipOval(
                    child: CachedNetworkImage(
                  width: 44,
                  height: 44,
                  imageUrl: item.data.header.icon,
                )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.data.header.title,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            Text(item.data.header.description,
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                          ],
                        ))),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    child: Text(
                      '+ 关注',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 240,
            child: ListView.builder(
                itemCount: item.data.itemList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return FollowWidgetItem(item: item.data.itemList[index]);
                }),
          )
        ],
      ),
    );
  }
}

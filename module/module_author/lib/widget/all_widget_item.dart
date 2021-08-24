import 'package:flutter/material.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:lib_ui/widget/remod_more_text_widget.dart';
import 'package:module_common/constant/color.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:lib_utils/share_util.dart';

class AllWidgetItem extends StatelessWidget {
  final Item item;

  const AllWidgetItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => toNamed('/author', item.data.author.id),
                child: ClipOval(
                  child: cacheImage(
                    item.data.author.icon,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.data.author.name,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        item.data.author.description,
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
          _tagWidget(),
          InkWell(
            onTap: () => toNamed("/detail", item.data),
            child: Hero(
              tag: '${item.data.id}${item.data.time}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: cacheImage(
                  item.data.cover.feed,
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                ),
              ),
            ),
          ),
          _desWidget(),
          _consumptionWidget()
        ],
      ),
    );
  }

  Widget _desWidget() {
    var textStyle = const TextStyle(
        fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold);
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ReadMoreTextWidget(
        item.data.description,
        style: TextStyle(fontSize: 14, color: Colors.black54),
        moreStyle: textStyle,
        lessStyle: textStyle,
        trimLines: 3,
      ),
    );
  }

  Widget _tagWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: _getTagWidgetList(),
      ),
    );
  }

  List<Widget> _getTagWidgetList() {
    List<Widget> widgetList = item.data.tags.map((tag) {
      return Container(
          margin: EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          height: 20,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: tabBgColor, borderRadius: BorderRadius.circular(4)),
          child: Text(
            tag.name,
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ));
    }).toList();
    return widgetList.length > 3 ? widgetList.sublist(0, 3) : widgetList;
  }

  Widget _consumptionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.favorite_border, size: 20, color: Colors.black54),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('${item.data.consumption.collectionCount}',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star_border, size: 20, color: Colors.black54),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('${item.data.consumption.realCollectionCount}',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.mode_comment_outlined, size: 20, color: Colors.black54),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('${item.data.consumption.replyCount}',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            )
          ],
        ),
        IconButton(
            icon: Icon(Icons.share_outlined, color: Colors.black54),
            onPressed: () => share(item.data.title, item.data.playUrl))
      ],
    );
  }
}

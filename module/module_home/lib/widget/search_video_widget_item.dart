import 'package:flutter/material.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:lib_utils/date_util.dart';
import 'package:module_common/model/common_item_model.dart';

class SearchVideoWidgetItem extends StatelessWidget {
  final Item item;

  const SearchVideoWidgetItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          toNamed('/detail', item.data);
        },
        child: Container(
            child: Stack(alignment: Alignment.center, children: <Widget>[
          Hero(
              tag: '${item.data?.id}${item.data?.time}',
              child: cacheImage(
                item.data?.cover?.feed ?? '',
                width: double.infinity, //撑满整个屏幕
                height: 220,
              )),
          Positioned(
              child: Column(children: <Widget>[
            Text(
              item.data?.title ?? '',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.black54),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        formatDateMsByMS(item.data?.duration ?? 0 * 1000),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ))),
            )
          ]))
        ])));
  }
}

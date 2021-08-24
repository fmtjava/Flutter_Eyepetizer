import 'package:flutter/material.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_common/model/common_item_model.dart';
import 'author_common_horizontal_widget_item.dart';

class SpecialWidgetItem extends StatelessWidget {
  final Item item;

  const SpecialWidgetItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print("点了");
                    toNamed('/author', item.data.header.id);
                  },
                  child: ClipOval(
                    child: cacheImage(
                      item.data.header.icon,
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
                            item.data.header.title,
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 14),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              item.data.header.description,
                              style: const TextStyle(
                                  color: Colors.black38, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          AuthorCommonHorizontalWidgetItem(
            item: item,
          )
        ],
      ),
    );
  }
}

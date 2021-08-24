import 'package:flutter/material.dart';
import 'package:module_author/widget/special_horizontal_widget_item.dart';
import 'package:module_common/model/common_item_model.dart';

class AuthorCommonHorizontalWidgetItem extends StatelessWidget {
  final Item item;

  const AuthorCommonHorizontalWidgetItem({Key key, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SpecialHorizontalWidgetItem(
            item: item.data.itemList[index],
            isLast: index == item.data.itemList.length - 1,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: item.data.itemList.length,
      ),
    );
  }
}

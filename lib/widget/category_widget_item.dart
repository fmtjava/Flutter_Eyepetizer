import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/util/view_util.dart';

class CategoryWidgetItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryWidgetItem({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: cacheImage(categoryModel.bgPicture)),
      Center(
          child: Text('#${categoryModel.name}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)))
    ]);
  }
}

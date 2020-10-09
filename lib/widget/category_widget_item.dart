import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';

class CategoryWidgetItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryWidgetItem({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(imageUrl: categoryModel.bgPicture)),
      Center(
          child: Text('#${categoryModel.name}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)))
    ]);
  }
}

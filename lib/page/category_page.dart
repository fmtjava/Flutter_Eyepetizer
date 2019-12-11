import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/repository/category_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/category_widget_item.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<CategoryModel> _list = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingContainer(
      loading: _loading,
      child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(color: Color(0xfff2f2f2)),
          child: GridView.builder(
              itemCount: _list?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return CategoryWidgetItem(categoryModel: _list[index]);
              })),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _loadData() async {
    try {
      List<CategoryModel> list = await CategoryRepository.getCategoryList();
      if (mounted) {
        setState(() {
          _list = list;
          _loading = false;
        });
      }
    } catch (e) {
      ToastUtil.showError(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }
}

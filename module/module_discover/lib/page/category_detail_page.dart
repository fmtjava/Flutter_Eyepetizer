import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_core/widget/provider_widget.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:module_common/widget/rank_widget_item.dart';
import 'package:module_discover/model/category_model.dart';
import 'package:module_discover/viewmodel/category_detail_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lib_navigator/lib_navigator.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProviderWidget<CategoryDetailModel>(
            model: CategoryDetailModel(widget.categoryModel.id ?? 0),
            onModelInit: (model) {
              model.loadMore(loadMore: false);
            },
            builder: (context, model, child) {
              return NestedScrollView(
                  //支持嵌套滚动
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                          leading: GestureDetector(
                              onTap: () => back(),
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black)),
                          elevation: 0,
                          systemOverlayStyle: SystemUiOverlayStyle(),
                          backgroundColor: Colors.white,
                          expandedHeight: 200.0,
                          pinned: true,
                          flexibleSpace:
                              LayoutBuilder(builder: (context, constraints) {
                            model.changeExpendStatusByOffset(
                                (MediaQuery.of(context).padding.top).toInt() +
                                    56,
                                constraints.biggest.height.toInt());
                            return FlexibleSpaceBar(
                                //可折叠状态栏
                                title: Text(
                                  widget.categoryModel.name ?? '',
                                  style: TextStyle(
                                      color: model.expend
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                centerTitle: false,
                                background: cacheImage(
                                    widget.categoryModel.bgPicture ?? ''));
                          }))
                    ];
                  },
                  body: LoadingContainer(
                    viewState: model.viewState,
                    retry: model.retry,
                    child: SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        onLoading: model.loadMore,
                        controller: model.refreshController,
                        child: ListView.builder(
                            itemCount: model.itemList.length,
                            itemBuilder: (context, index) {
                              return RankWidgetItem(
                                  item: model.itemList[index],
                                  showCategory: false,
                                  showDivider: false);
                            })),
                  ));
            }));
  }
}

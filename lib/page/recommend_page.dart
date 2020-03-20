import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/provider/recommend_page_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/recommend_widget_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('RecommendPage');
    return ProviderWidget<RecommendPageModel>(
        model: RecommendPageModel(),
        onModelInit: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return Scaffold(
            body: LoadingContainer(
                loading: model.loading,
                child: Container(
                  decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                  child: SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: model.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RecommendWidgetItem(
                              item: model.itemList[index]);
                        },
                        staggeredTileBuilder: (int index) {
                          return StaggeredTile.fit(2);
                        },
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      )),
                )),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:lib_core/widget/provider_widget.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:module_common/widget/rank_widget_item.dart';
import 'package:module_hot/viewmodel/rank_list_page_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPage extends StatefulWidget {
  final String apiUrl;

  const RankListPage({Key? key, required this.apiUrl}) : super(key: key);

  @override
  _RankListPageState createState() => _RankListPageState();
}

class _RankListPageState extends State<RankListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<RankListPageModel>(
        model: RankListPageModel(),
        onModelInit: (model) {
          model.init(widget.apiUrl);
          model.loadData();
        },
        builder: (context, model, child) {
          return LoadingContainer(
            viewState: model.viewState,
            retry: model.retry,
            child: SmartRefresher(
                controller: model.refreshController,
                enablePullDown: true,
                onRefresh: model.loadData,
                child: ListView.separated(
                  itemCount: model.itemList.length,
                  itemBuilder: (context, index) {
                    return RankWidgetItem(item: model.itemList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Divider(height: 0.5));
                  },
                )),
          );
        });
  }

  @override
  bool get wantKeepAlive => true; //设置页面缓存
}

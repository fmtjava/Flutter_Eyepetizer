import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/page/topics_detail_page.dart';
import 'package:flutter_eyepetizer/provider/topic_page_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/topic_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TopicPageModel>(
        model: TopicPageModel(),
        onModelInit: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return LoadingContainer(
              loading: model.loading,
              error: model.error,
              retry: model.retry,
              child: SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return OpenContainer(closedBuilder: (context, action) {
                          return TopicWidgetItem(
                              itemModel: model.itemList[index]);
                        }, openBuilder: (context, action) {
                          return TopicDetailPage(
                              detailId: model.itemList[index].data.id);
                        });
                      },
                      itemCount: model.itemList.length)));
        });
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/provider/follow_page_model.dart';
import 'package:flutter_eyepetizer/widget/follow_page_item.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<FollowPageModel>(
        model: FollowPageModel(),
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
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return FollowPageItem(item: model.itemList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 0.5);
                      },
                      itemCount: model.itemList.length)));
        });
  }

  @override
  bool get wantKeepAlive => true;
}

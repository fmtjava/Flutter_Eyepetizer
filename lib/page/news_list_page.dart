import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/provider/news_page_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/news_widget_item.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const TEXT_CARD_TYPE = "textCard";
const INFORMATION_CARD_TYPE = "informationCard";

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<NewsPageModel>(
        model: NewsPageModel(),
        onModelInit: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return LoadingContainer(
              loading: model.loading,
              error: model.error,
              retry: model.retry,
              child: Container(
                  color: Colors.white,
                  child: SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (model.itemList[index].type == TEXT_CARD_TYPE) {
                              return NewsTitleWidgetItem(
                                  newsItemModel: model.itemList[index]);
                            } else {
                              return NewsContentWidgetItem(
                                  newsItemModel: model.itemList[index]);
                            }
                          },
                          itemCount: model.itemList.length))));
        });
  }

  @override
  bool get wantKeepAlive => true;
}

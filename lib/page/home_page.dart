import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/page/video_search_page.dart';
import 'package:flutter_eyepetizer/provider/home_page_model.dart';
import 'package:flutter_eyepetizer/widget/appbar_widget.dart';
import 'package:flutter_eyepetizer/widget/banner_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/rank_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const TEXT_HEADER_TYPE = 'textHeader';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
          DString.daily_paper,
          showBack: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: OpenContainer(
                  closedElevation: 0.0,
                  closedBuilder: (context, action) {
                    return Icon(
                      Icons.search,
                      color: Colors.black87,
                    );
                  },
                  openBuilder: (context, action) {
                    return VideoSearchPage();
                  }),
            )
          ],
        ),
        body: ProviderWidget<HomePageModel>(
            model: HomePageModel(),
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
                          if (index == 0) {
                            return _banner(model);
                          } else {
                            if (model.itemList[index].type ==
                                TEXT_HEADER_TYPE) {
                              return _titleItem(model.itemList[index]);
                            }
                            return RankWidgetItem(item: model.itemList[index]);
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Divider(
                                  height: model.itemList[index].type ==
                                              TEXT_HEADER_TYPE ||
                                          index == 0
                                      ? 0
                                      : 0.5,
                                  color: model.itemList[index].type ==
                                              TEXT_HEADER_TYPE ||
                                          index == 0
                                      ? Colors.transparent
                                      : Color(0xffe6e6e6)));
                        },
                        itemCount: model.itemList.length)),
              );
            }));
  }

  _banner(HomePageModel model) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

  _titleItem(Item item) {
    return Container(
        decoration: BoxDecoration(color: Colors.white24),
        padding: EdgeInsets.only(top: 15, bottom: 5),
        child: Center(
            child: Text(item.data.text,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold))));
  }

  @override
  bool get wantKeepAlive => true;
}

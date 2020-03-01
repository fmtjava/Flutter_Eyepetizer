import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/provider/home_page_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/rank_widget_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

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
        appBar: AppBar(
          title: Text('日报',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          brightness: Brightness.light,
          //设置状态栏字体
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ProviderWidget<HomePageModel>(
            model: HomePageModel(),
            onModelInit: (model) {
              model.refresh();
            },
            builder: (context, model, child) {
              return LoadingContainer(
                loading: model.loading,
                child: SmartRefresher(
                    controller: model.refreshController,
                    onRefresh: model.refresh,
                    onLoading: model.loadMore,
                    enablePullUp: true,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _banner(context);
                          } else {
                            if (model.itemList[index].type == 'textHeader') {
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
                                              'textHeader' ||
                                          index == 0
                                      ? 0
                                      : 0.5,
                                  color: model.itemList[index].type ==
                                              'textHeader' ||
                                          index == 0
                                      ? Colors.transparent
                                      : Color(0xffe6e6e6)));
                        },
                        itemCount: model.itemList.length)),
              );
            }));
  }

  _banner(BuildContext context) {
    HomePageModel model = Provider.of(context);
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Stack(
        children: <Widget>[
          Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Hero(
                    tag: model.bannerList[index].data.id,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  model.bannerList[index].data.cover.feed),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(4)),
                    ));
              },
              onIndexChanged: (index) {
                model.changeBannerIndex(index);
              },
              onTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VideoDetailPage(item: model.bannerList[index])));
              },
              itemCount: model.bannerList?.length ?? 0,
              pagination: new SwiperPagination(
                  alignment: Alignment.bottomRight,
                  builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.white, color: Colors.white24))),
          Positioned(
              width: MediaQuery.of(context).size.width - 30,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4))),
                  child: Text(model.bannerList[model.currentIndex].data.title,
                      style: TextStyle(color: Colors.white, fontSize: 12))))
        ],
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

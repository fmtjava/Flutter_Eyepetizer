import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/repository/home_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/rank_widget_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const DEFAULT_URL = 'http://baobab.kaiyanapp.com/api/v2/feed?num=1';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<Item> _bannerList = [];
  List<Item> _itemList = [];
  int _currentIndex = 0;
  String _nextPageUrl;
  bool _loading = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _refresh();
  }

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
        body: LoadingContainer(
          loading: _loading,
          child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _refresh,
              onLoading: _loadMore,
              enablePullUp: true,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _banner(context);
                    } else {
                      if (_itemList[index].type == 'textHeader') {
                        return _titleItem(_itemList[index]);
                      }
                      return RankWidgetItem(item: _itemList[index]);
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Divider(
                            height: _itemList[index].type == 'textHeader' ||
                                    index == 0
                                ? 0
                                : 0.5,
                            color: _itemList[index].type == 'textHeader' ||
                                    index == 0
                                ? Colors.transparent
                                : Color(0xffe6e6e6)));
                  },
                  itemCount: _itemList.length)),
        ));
  }

  _banner(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Stack(
        children: <Widget>[
          Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              _bannerList[index].data.cover.feed),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(4)),
                );
              },
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onTap: (index) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VideoDetailPage(item: _bannerList[index])));
              },
              itemCount: _bannerList?.length ?? 0,
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
                  child: Text(_bannerList[_currentIndex].data.title,
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

  void _refresh() async {
    var url = DEFAULT_URL;
    try {
      IssueEntity issueEntity = await HomeRepository.getHomeList(url);
      List<Item> list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });
      if (mounted) {
        setState(() {
          _itemList.clear();
          _itemList.add(Item()); //为Banner占位
          _bannerList = list;
          _loading = false;
        });
      }
      _nextPageUrl = issueEntity.nextPageUrl;
      _refreshController.refreshCompleted();
      _refreshController.footerMode.value = LoadStatus.canLoading;
      _loadMore();
    } catch (e) {
      ToastUtil.showError(e.toString());
      _refreshController.loadFailed();
      setState(() {
        _loading = false;
      });
    }
  }

  void _loadMore() async {
    if (_nextPageUrl == null) {
      _refreshController.loadNoData();
      return;
    }
    try {
      IssueEntity issueEntity = await HomeRepository.getHomeList(_nextPageUrl);
      List<Item> list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });
      if (mounted) {
        setState(() {
          _itemList.addAll(list);
        });
      }
      _nextPageUrl = issueEntity.nextPageUrl;
      _refreshController.loadComplete();
    } catch (e) {
      ToastUtil.showError(e.toString());
      _refreshController.loadFailed();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:lib_core/state/base_state.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/config/color.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:module_author/constant/api_service.dart';
import 'package:module_author/constant/string.dart';
import 'package:module_author/delegate/sticky_tabbar_delegate.dart';
import 'package:module_author/page/all_tab_page.dart';
import 'package:module_author/page/home_tab_page.dart';
import 'package:module_common/model/tab_info_model.dart';
import 'special_tab_page.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends BaseState<AuthorPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late int authorId;
  ViewState viewState = ViewState.loading;
  late PgcInfo? pgcInfo;
  late TabController _tabController;

  List<TabInfoItem> tabList = [];
  List<Widget> pageList = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    authorId = arguments();
    _tabController = new TabController(length: tabList.length, vsync: this);
    _loadData();
  }

  //记录SliverAppBar上一次的状态
  bool _sliverAppBarLastStatus = true;

  //滚动回调事件
  _scrollListener() {
    //不断比较最近两次的滚动状态，进而判断是展开还是收起
    if (isShrink != _sliverAppBarLastStatus) {
      setState(() {
        _sliverAppBarLastStatus = isShrink;
      });
    }
  }

  //是否折叠
  bool get isShrink =>
      _scrollController.hasClients &&
      _scrollController.offset > (200 - kToolbarHeight);

  void _loadData() async {
    String url =
        '${URLs.tabUrl}$authorId&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5';
    await HttpManager.getData(url, success: (result) {
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);
      setState(() {
        viewState = ViewState.content;
        tabList = tabInfoModel.tabInfo?.tabList ?? [];
        if (tabList.length == 2) {
          pageList = [
            HomeTabPage(apiUrl: tabList[0].apiUrl),
            AllTabPage(apiUrl: tabList[1].apiUrl)
          ];
        } else {
          pageList = [
            HomeTabPage(apiUrl: tabList[0].apiUrl),
            AllTabPage(apiUrl: tabList[1].apiUrl),
            SpecialTabPage(apiUrl: tabList[2].apiUrl)
          ];
        }
        pgcInfo = tabInfoModel.pgcInfo;
        _tabController = TabController(
            length: tabInfoModel.tabInfo?.tabList?.length ?? 0, vsync: this);
      });
    }, fail: (e) {
      viewState = ViewState.error;
      showError(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        viewState: viewState,
        child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[_sliverAppBar(), _sliverPersistentHeader()];
            },
            body: TabBarView(controller: _tabController, children: pageList)),
        retry: _loadData,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      centerTitle: false,
      elevation: 0,
      pinned: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => back(),
        icon: Icon(Icons.arrow_back,
            color: isShrink ? Colors.black : Colors.white),
      ),
      title: Text(
        pgcInfo?.name ?? '',
        style: TextStyle(
          color: isShrink ? Colors.black : Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: pgcInfo?.cover == null
                    ? AssetImage('images/ic_default_header_bg.png',
                        package: 'module_author')
                    : cachedNetworkImageProvider(
                        pgcInfo?.cover ?? '',
                      ))),
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ClipOval(
                    child:
                        cacheImage(pgcInfo?.icon ?? '', height: 40, width: 40),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pgcInfo?.description ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      pgcInfo?.brief ?? '',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoWidget('${pgcInfo?.videoCount}', author_works),
                  _infoWidget('${pgcInfo?.followCount}', author_flows),
                  _infoWidget('${pgcInfo?.shareCount}', author_share),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _sliverPersistentHeader() {
    return SliverPersistentHeader(
        pinned: true,
        delegate: StickyTabBarDelegate(
            child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: hitTextColor,
          labelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabList.map((tab) => Tab(text: tab.name)).toList(),
          controller: _tabController,
        )));
  }

  Widget _infoWidget(String count, String text) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

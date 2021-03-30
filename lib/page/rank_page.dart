import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/core/base_state.dart';
import 'package:flutter_eyepetizer/model/tab_info_model.dart';
import 'package:flutter_eyepetizer/page/rank_list_page.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/tab_bar_widget.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends BaseState<RankPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController;
  List<TabInfoItem> _tabList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(DString.popularity_list,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          brightness: Brightness.light,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            TabBarWidget(
                tabController: _tabController,
                tabs: _tabList.map((TabInfoItem tabInfoItem) {
                  return Tab(text: tabInfoItem.name);
                }).toList(),
                onTap: (index) => _pageController.animateToPage(index,
                    duration: kTabScrollDuration, curve: Curves.ease)),
            Expanded(
                child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) => _tabController.index = index,
                    children: _tabList.map((TabInfoItem tabInfoItem) {
                      return RankListPage(apiUrl: tabInfoItem.apiUrl);
                    }).toList())),
          ],
        ));
  }

  void _loadData() async {
    await ApiService.getData(ApiService.rank_url, success: (result) {
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);
      setState(() {
        _tabList = tabInfoModel.tabInfo.tabList;
        _tabController = TabController(length: _tabList.length, vsync: this);
      });
    }, fail: (e) {
      showError(e.toString());
    });
  }

  @override
  bool get wantKeepAlive => true;
}

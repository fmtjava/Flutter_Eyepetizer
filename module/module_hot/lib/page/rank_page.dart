import 'package:flutter/material.dart';
import 'package:lib_core/state/base_state.dart';
import 'package:lib_net/http_manager.dart';
import 'package:lib_ui/widget/appbar_widget.dart';
import 'package:lib_ui/widget/tab_bar_widget.dart';
import 'package:lib_utils/toast_util.dart';
import 'package:module_common/model/tab_info_model.dart';
import 'package:module_hot/constant/api_service.dart';
import 'package:module_hot/constant/string.dart';
import 'package:module_hot/page/rank_list_page.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends BaseState<RankPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late PageController _pageController;
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
        appBar: appBar(popularity_list, showBack: false),
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
                      return RankListPage(apiUrl: tabInfoItem.apiUrl ?? '');
                    }).toList())),
          ],
        ));
  }

  void _loadData() async {
    await HttpManager.getData(URLs.rankUrl, success: (result) {
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);
      setState(() {
        if (tabInfoModel.tabInfo != null &&
            tabInfoModel.tabInfo?.tabList != null) {
          _tabList = tabInfoModel.tabInfo!.tabList!;
          _tabController = TabController(length: _tabList.length, vsync: this);
        }
      });
    }, fail: (e) {
      showError(e.toString());
    });
  }

  @override
  bool get wantKeepAlive => true;
}

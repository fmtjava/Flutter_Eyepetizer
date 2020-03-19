import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/tab_info_model.dart';
import 'package:flutter_eyepetizer/page/rank_list_page.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<TabInfoItem> _tabList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('人气榜',
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
            TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xff9a9a9a),
                labelStyle: TextStyle(fontSize: 14),
                unselectedLabelStyle: TextStyle(fontSize: 14),
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: _tabList.map((TabInfoItem tabInfoItem) {
                  return Tab(text: tabInfoItem.name);
                }).toList()),
            Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: _tabList.map((TabInfoItem tabInfoItem) {
                      return RankListPage(apiUrl: tabInfoItem.apiUrl);
                    }).toList()))
          ],
        ));
  }

  void _loadData() async {
    await ApiService.getData(ApiService.rank_url, success: (result) {
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);
      if (mounted) {
        //判断是否渲染完成，防止数据还没有获取到，此时setState触发的控件渲染就会报错
        setState(() {
          _tabList = tabInfoModel.tabInfo.tabList;
          _tabController = TabController(length: _tabList.length, vsync: this);
        });
      }
    }, fail: (e) {
      ToastUtil.showError(e.toString());
    });
  }
}

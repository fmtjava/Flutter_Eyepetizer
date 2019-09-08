import 'package:flutter/material.dart';

import 'category_page.dart';
import 'follow_page.dart';

const TAB_LABEL = ['关注', '分类'];

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('发现',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Color(0xff9a9a9a),
                  labelStyle: TextStyle(fontSize: 14),
                  unselectedLabelStyle: TextStyle(fontSize: 14),
                  indicatorColor: Colors.black,
                  indicatorSize:TabBarIndicatorSize.label,
                  tabs: TAB_LABEL.map((String label) {
                    return Tab(text: label);
                  }).toList()),
            ),
            Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: [FollowPage(), CategoryPage()]))
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

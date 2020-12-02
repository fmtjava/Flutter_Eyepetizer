import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/page/discovery_page.dart';
import 'package:flutter_eyepetizer/page/home_page.dart';
import 'package:flutter_eyepetizer/page/mine_page.dart';
import 'package:flutter_eyepetizer/page/rank_page.dart';
import 'package:flutter_eyepetizer/provider/tab_navigation_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  PageController _pageController = PageController();
  DateTime lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomePage(),
              DiscoveryPage(),
              RankPage(),
              MinePage()
            ],
          ),
          bottomNavigationBar: ProviderWidget<TabNavigationModel>(
              model: TabNavigationModel(),
              builder: (context, model, child) {
                return BottomNavigationBar(
                  currentIndex: model.currentIndex,
                  onTap: (index) {
                    if (model.currentIndex != index) {
                      _pageController.jumpToPage(index);
                      model.changeBottomTabIndex(index);
                    }
                  },
                  type: BottomNavigationBarType.fixed,
                  //显示标题
                  items: [
                    _bottomItem(
                        DString.daily_paper,
                        'images/ic_home_normal.png',
                        'images/ic_home_selected.png'),
                    _bottomItem(
                        DString.discover,
                        'images/ic_discovery_normal.png',
                        'images/ic_discovery_selected.png'),
                    _bottomItem(DString.hot, 'images/ic_hot_normal.png',
                        'images/ic_hot_selected.png'),
                    _bottomItem(DString.mime, 'images/ic_mine_normal.png',
                        'images/ic_mine_selected.png')
                  ],
                  selectedItemColor: Color(0xff000000),
                  unselectedItemColor: Color(0xff9a9a9a),
                );
              }),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtil.showTip(DString.exit_tip);
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  _bottomItem(String title, String normalIcon, String selectIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(normalIcon, width: 24, height: 24),
        activeIcon: Image.asset(selectIcon, width: 24, height: 24),
        label: title);
  }
}

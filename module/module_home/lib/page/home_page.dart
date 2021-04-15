import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lib_ui/widget/appbar_widget.dart';
import 'package:module_home/const/string.dart';
import 'package:module_home/page/video_search_page.dart';

import 'home_tab_page.dart';

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
          daily_paper,
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
        body: HomeTabPage());
  }

  @override
  bool get wantKeepAlive => true;
}

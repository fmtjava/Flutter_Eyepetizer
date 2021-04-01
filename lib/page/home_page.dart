import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/page/home_tab_page.dart';
import 'package:flutter_eyepetizer/page/video_search_page.dart';
import 'package:flutter_eyepetizer/widget/appbar_widget.dart';


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
        body: HomeTabPage());
  }

  @override
  bool get wantKeepAlive => true;
}

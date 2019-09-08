
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/page/rank_page.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return RankPage();
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/rank_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/rank_widget_item.dart';

class RankListPage extends StatefulWidget {
  final String apiUrl;

  const RankListPage({Key key, this.apiUrl}) : super(key: key);

  @override
  _RankListPageState createState() => _RankListPageState();
}

class _RankListPageState extends State<RankListPage>
    with AutomaticKeepAliveClientMixin {
  List<Item> _itemList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return LoadingContainer(
      loading: _loading,
      child: Container(
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  itemCount: _itemList.length,
                  itemBuilder: (context, index) {
                    return RankWidgetItem(item: _itemList[index]);
                  }))),
    );
  }

  @override
  bool get wantKeepAlive => true; //设置页面缓存

  void _loadData() async {
    try {
      Issue issueModel = await RankRepository.getRankList(widget.apiUrl);
      if (mounted) {
        setState(() {
          _itemList = issueModel.itemList;
          _loading = false;
        });
      }
    } catch (e) {
      ToastUtil.showError(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }
}

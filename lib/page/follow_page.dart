import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/follow_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/follow_page_item.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const DEFAULT_URL = 'http://baobab.kaiyanapp.com/api/v4/tabs/follow';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with AutomaticKeepAliveClientMixin {
  List<Item> _itemList;
  String _nextPageUrl;
  bool _loading = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingContainer(
        loading: _loading,
        child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _refresh,
            onLoading: _loadMore,
            enablePullUp: true,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return FollowPageItem(item: _itemList[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.5);
                },
                itemCount: _itemList?.length ?? 0)));
  }

  void _refresh() async {
    var url = DEFAULT_URL;
    try {
      Issue issueModel = await FollowRepository.getFollowList(url);
      if (mounted) {
        setState(() {
          _itemList = issueModel.itemList;
          _loading = false;
        });
      }
      _nextPageUrl = issueModel.nextPageUrl;
      _refreshController.refreshCompleted();
      _refreshController.footerMode.value = LoadStatus.canLoading;
    } catch (e) {
      ToastUtil.showError(e.toString());
      _refreshController.loadFailed();
      setState(() {
        _loading = false;
      });
    }
  }

  void _loadMore() async {
    if (_nextPageUrl == null) {
      _refreshController.loadNoData();
      return;
    }
    try {
      Issue issue = await FollowRepository.getFollowList(_nextPageUrl);
      if (mounted) {
        setState(() {
          _itemList.addAll(issue.itemList);
          _loading = false;
        });
      }
      _nextPageUrl = issue.nextPageUrl;
      _refreshController.loadComplete();
    } catch (e) {
      ToastUtil.showError(e.toString());
      _refreshController.loadFailed();
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

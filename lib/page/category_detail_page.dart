import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/category_model.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/category_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/load_more_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/rank_widget_item.dart';

const DEFAULT_URL = 'http://baobab.kaiyanapp.com/api/v4/categories/videoList?';

class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<Item> _itemList = [];
  String _nextPageUrl;
  ScrollController _scrollController = ScrollController();
  bool _isLoadMore = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      //判断滚动的距离是否大于最大距离)
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadMore) {
        //防止多次加载
        _loadMore();
      }
    });
    _loadMore(loadMore: false);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LoadingContainer(
          loading: _loading,
          child: CustomScrollView(
            controller: _scrollController,
            //CustomScrollView结合Sliver家族控件实现可折叠状态栏
            slivers: <Widget>[
              SliverAppBar(
                  elevation: 0,
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(widget.categoryModel.name),
                      centerTitle: false,
                      background: CachedNetworkImage(
                          imageUrl: widget.categoryModel.bgPicture,
                          fit: BoxFit.cover))),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index < _itemList.length) {
                  return RankWidgetItem(
                      item: _itemList[index],
                      showCategory: false,
                      showDivider: false);
                }
                return LoadMoreWidget(isLoadMore: _isLoadMore); //加载更多布局
              }, childCount: _itemList.length + 1))
            ],
          ),
        ));
  }

  void _loadMore({loadMore = true}) async {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        setState(() {
          _isLoadMore = false;
        });
        return;
      }
      setState(() {
        _isLoadMore = true;
      });
      url = _nextPageUrl +
          "&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url);
    } else {
      url = DEFAULT_URL +
          "id=${widget.categoryModel.id}&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url);
    }
  }

  void getData(String url) async {
    try {
      Issue issue = await CategoryRepository.getCategoryDetailList(url);
      if (mounted) {
        setState(() {
          if (_isLoadMore) {
            _isLoadMore = false;
          }
          _loading = false;
          _itemList.addAll(issue.itemList);
        });
      }
      _nextPageUrl = issue.nextPageUrl;
    } catch (e) {
      ToastUtil.showError(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }
}

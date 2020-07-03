import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/recommend_model.dart';
import 'package:flutter_eyepetizer/repository/recommend_repository.dart';
import 'package:flutter_eyepetizer/widget/recommend_widget_item.dart';
import 'package:loading_more_list/loading_more_list.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  RecommendRepository _recommendRepository = RecommendRepository();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: LayoutBuilder(
          builder: (BuildContext c, BoxConstraints data) {
            final int crossAxisCount =
                max(data.maxWidth ~/ (ScreenUtil.getScreenW(context) / 2.0), 2);
            return LoadingMoreList<RecommendItem>(
              ListConfig<RecommendItem>(
                extendedListDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, item, index) =>
                    RecommendWidgetItem(item: item),
                sourceList: _recommendRepository,
                padding: const EdgeInsets.all(5.0),
                lastChildLayoutType: LastChildLayoutType.foot,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _recommendRepository.dispose();
  }

  Future<void> _refresh() async {
    return _recommendRepository.refresh().whenComplete(() => null);
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/topic_model.dart';
import 'package:flutter_eyepetizer/page/topics_detail_page.dart';
import 'package:flutter_eyepetizer/viewmodel/topic_page_model.dart';
import 'package:flutter_eyepetizer/widget/topic_widget_item.dart';
import 'package:lib_core/state/base_list_state.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState
    extends BaseListState<TopicItemModel, TopicPageModel, TopicsPage> {
  @override
  Widget getContentChild(TopicPageModel model) => ListView.builder(
      itemBuilder: (context, index) {
        return OpenContainer(closedBuilder: (context, action) {
          return TopicWidgetItem(itemModel: model.itemList[index]);
        }, openBuilder: (context, action) {
          return TopicDetailPage(detailId: model.itemList[index].data.id);
        });
      },
      itemCount: model.itemList.length);

  @override
  TopicPageModel get viewModel => TopicPageModel();
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lib_core/state/base_list_state.dart';
import 'package:module_discover/model/topic_model.dart';
import 'package:module_discover/page/topics_detail_page.dart';
import 'package:module_discover/viewmodel/topic_page_model.dart';
import 'package:module_discover/widget/topic_widget_item.dart';

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
          return TopicDetailPage(detailId: model.itemList[index].data?.id ?? 0);
        });
      },
      itemCount: model.itemList.length);

  @override
  TopicPageModel get viewModel => TopicPageModel();
}

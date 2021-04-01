import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/core/base_list_state.dart';
import 'package:flutter_eyepetizer/model/news_model.dart';
import 'package:flutter_eyepetizer/viewmodel/news_page_model.dart';
import 'package:flutter_eyepetizer/widget/news_widget_item.dart';

const TEXT_CARD_TYPE = "textCard";
const INFORMATION_CARD_TYPE = "informationCard";

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState
    extends BaseListState<NewsItemModel, NewsPageModel, NewsListPage> {
  @override
  NewsPageModel get viewModel => NewsPageModel();

  @override
  Widget getContentChild(NewsPageModel model) => ListView.builder(
      itemBuilder: (context, index) {
        if (model.itemList[index].type == TEXT_CARD_TYPE) {
          return NewsTitleWidgetItem(newsItemModel: model.itemList[index]);
        } else {
          return NewsContentWidgetItem(newsItemModel: model.itemList[index]);
        }
      },
      itemCount: model.itemList.length);
}

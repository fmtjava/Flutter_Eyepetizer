import 'package:flutter/material.dart';
import 'package:module_author/widget/all_widget_item.dart';
import 'package:lib_core/state/base_list_state.dart';
import 'package:module_author/viewmodel/author_tab_page_model.dart';
import 'package:module_common/model/common_item_model.dart';

class AllTabPage extends StatefulWidget {
  final apiUrl;

  const AllTabPage({Key key, this.apiUrl}) : super(key: key);

  @override
  _AllTabPageState createState() => _AllTabPageState();
}

class _AllTabPageState
    extends BaseListState<Item, AuthorTabPageModel, AllTabPage> {
  @override
  Widget getContentChild(AuthorTabPageModel model) => ListView.separated(
      itemBuilder: (context, index) {
        return AllWidgetItem(
          item: model.itemList[index],
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            height: 0.5,
          ),
        );
      },
      itemCount: model.itemList.length);

  @override
  AuthorTabPageModel get viewModel => AuthorTabPageModel(widget.apiUrl);

  @override
  bool get enablePullDown => false;
}

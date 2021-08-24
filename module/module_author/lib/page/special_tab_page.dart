import 'package:flutter/material.dart';
import 'package:lib_core/state/base_list_state.dart';
import 'package:module_author/viewmodel/author_tab_page_model.dart';
import 'package:module_author/widget/special_widget_item.dart';
import 'package:module_common/model/common_item_model.dart';

class SpecialTabPage extends StatefulWidget {
  final apiUrl;

  const SpecialTabPage({Key key, this.apiUrl}) : super(key: key);

  @override
  _SpecialTabPageState createState() => _SpecialTabPageState();
}

class _SpecialTabPageState
    extends BaseListState<Item, AuthorTabPageModel, SpecialTabPage> {
  @override
  Widget getContentChild(AuthorTabPageModel model) => ListView.separated(
      itemBuilder: (context, index) {
        return SpecialWidgetItem(
          item: model.itemList[index],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(height: 0.5);
      },
      itemCount: model.itemList.length);

  @override
  AuthorTabPageModel get viewModel => AuthorTabPageModel(widget.apiUrl);

  @override
  bool get enablePullDown => false;
}

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/core/base_list_state.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/viewmodel/follow_page_model.dart';
import 'package:flutter_eyepetizer/widget/follow_page_item.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}
class _FollowPageState extends BaseListState<Item,FollowPageModel,FollowPage>{
  @override
  Widget getContentChild(FollowPageModel model) => ListView.separated(
      itemBuilder: (context, index) {
        return FollowPageItem(item: model.itemList[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 0.5);
      },
      itemCount: model.itemList.length);

  @override
  FollowPageModel get viewModel => FollowPageModel();
}
import 'package:flutter/material.dart';
import 'package:lib_core/state/base_list_state.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_common/widget/rank_widget_item.dart';
import 'package:module_home/viewmodel/home_page_model.dart';
import 'package:module_home/widget/banner_widget.dart';

const TEXT_HEADER_TYPE = 'textHeader';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends BaseListState<Item, HomePageModel, HomeTabPage> {
  @override
  Widget getContentChild(HomePageModel model) => ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0) {
          return _banner(model);
        } else {
          if (model.itemList[index].type == TEXT_HEADER_TYPE) {
            return _titleItem(model.itemList[index]);
          }
          return RankWidgetItem(item: model.itemList[index]);
        }
      },
      separatorBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Divider(
                height:
                    model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                        ? 0
                        : 0.5,
                color:
                    model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                        ? Colors.transparent
                        : Color(0xffe6e6e6)));
      },
      itemCount: model.itemList.length);

  @override
  HomePageModel get viewModel => HomePageModel();

  _banner(HomePageModel model) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

  _titleItem(Item item) {
    return Container(
        decoration: BoxDecoration(color: Colors.white24),
        padding: EdgeInsets.only(top: 15, bottom: 5),
        child: Center(
            child: Text(item.data.text,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold))));
  }
}

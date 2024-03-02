import 'package:flutter/material.dart';
import 'package:lib_core/state/base_list_state.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_author/viewmodel/author_tab_page_model.dart';
import 'package:module_author/widget/author_common_horizontal_widget_item.dart';
import 'package:module_author/widget/special_widget_item.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_common/widget/video_relate_widget_item.dart';

const VIDEO_COLLECTION_OF_HORIZONTAL_SCROLL_CARD =
    "videoCollectionOfHorizontalScrollCard";
const TEXT_HEADER = "textHeader";
const VIDEO = "video";
const TEXT_FOOTER = "textFooter";
const VIDEO_COLLECTION_WITH_BRIEF = "videoCollectionWithBrief";

class HomeTabPage extends StatefulWidget {
  final apiUrl;

  const HomeTabPage({Key? key, this.apiUrl}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends BaseListState<Item, AuthorTabPageModel, HomeTabPage> {
  @override
  Widget getContentChild(AuthorTabPageModel model) => ListView.builder(
      itemBuilder: (context, index) {
        Item item = model.itemList[index];
        switch (item.type) {
          case VIDEO_COLLECTION_OF_HORIZONTAL_SCROLL_CARD:
            return _horizontalScrollCardItem(item);
          case TEXT_HEADER:
            return _titleItem(item.data?.text ?? '');
          case VIDEO:
            return VideoRelateWidgetItem(
              data: item.data,
              callBack: () {
                toNamed('/detail', item.data);
              },
              titleColor: Colors.black87,
              categoryColor: Colors.black26,
              openHero: true,
            );
          case TEXT_FOOTER:
            return _moreItem(item);
          case VIDEO_COLLECTION_WITH_BRIEF:
            return _videoBriefItem(item);
          default:
            return null;
        }
      },
      itemCount: model.itemList.length);

  Widget _titleItem(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _moreItem(Item item) {
    return Padding(
      padding: EdgeInsets.only(top: 15, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            item.data?.text ?? '',
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black26,
          )
        ],
      ),
    );
  }

  Widget _horizontalScrollCardItem(Item item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleItem(item.data?.header?.title ?? ''),
        AuthorCommonHorizontalWidgetItem(
          item: item,
        ),
        Divider()
      ],
    );
  }

  Widget _videoBriefItem(Item item) {
    return Column(
      children: [SpecialWidgetItem(item: item), Divider()],
    );
  }

  @override
  AuthorTabPageModel get viewModel => AuthorTabPageModel(widget.apiUrl);

  @override
  bool get enablePullDown => false;
}

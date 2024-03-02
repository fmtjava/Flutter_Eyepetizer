import 'package:flutter/material.dart';
import 'package:lib_ui/config/string.dart';

//封装加载更多控件
class LoadMoreWidget extends StatefulWidget {
  final bool isLoadMore;
  final String loadingText;
  final String loadMoreText;

  const LoadMoreWidget(
      {Key? key,
      this.isLoadMore = false,
      this.loadingText = loading_text,
      this.loadMoreText = load_more_text})
      : super(key: key);

  @override
  _LoadMoreWidgetState createState() => _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoadMore) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.loadingText, style: TextStyle(fontSize: 16)),
          Padding(
              padding: EdgeInsets.only(left: 5),
              child: CircularProgressIndicator())
        ],
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10),
        child: Text(widget.loadMoreText, style: TextStyle(fontSize: 16)),
      );
    }
  }
}

import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/provider/watch_history_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/video_relate_widget_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WatchHistoryPage extends StatefulWidget {
  @override
  _WatchHistoryPageState createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () => NavigatorManager.back(),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              ),
            ),
            title: Text(
              DString.watch_history,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0),
        body: ProviderWidget<WatchHistoryPageModel>(
            model: WatchHistoryPageModel(),
            onModelInit: (model) {
              model.loadData();
            },
            builder: (context, model, child) {
              return Stack(children: <Widget>[
                Offstage(
                    offstage:
                        model.itemList == null || model.itemList.length == 0,
                    child: Container(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              child: VideoRelateWidgetItem(
                                data: model.itemList[index],
                                callBack: () {
                                  NavigatorManager.to(VideoDetailPage(
                                      data: model.itemList[index]));
                                },
                                titleColor: Colors.black87,
                                categoryColor: Colors.black26,
                                openHero: true,
                              ),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () => model.remove(index),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: 15, top: 5, right: 15),
                                child: Divider(height: 0.5));
                          },
                          itemCount: model.itemList?.length ?? 0),
                      decoration: BoxDecoration(color: Colors.white),
                    )),
                Offstage(
                    //控制控件显示或隐藏
                    offstage:
                        model.itemList != null && model.itemList.length > 0,
                    child: Center(
                      child: Image.asset('images/ic_no_data.png'),
                    ))
              ]);
            }));
  }
}

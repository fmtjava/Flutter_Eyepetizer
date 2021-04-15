import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/viewmodel/topic_detail_page_model.dart';
import 'package:flutter_eyepetizer/widget/appbar_widget.dart';
import 'package:flutter_eyepetizer/widget/topic_detail_widget_item.dart';
import 'package:lib_core/widget/provider_widget.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_ui/widget/loading_container.dart';

class TopicDetailPage extends StatefulWidget {
  final int detailId;

  const TopicDetailPage({Key key, this.detailId}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TopicDetailPageModel>(
        model: TopicDetailPageModel(),
        onModelInit: (model) {
          model.loadTopicDetailData(widget.detailId);
        },
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: appBar(model.topicDetailModel.brief),
              body: LoadingContainer(
                  viewState: model.viewState,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      _headWidget(model.topicDetailModel),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return TopicDetailWidgetItem(
                            model: model.itemList[index]);
                      }, childCount: model.itemList.length))
                    ],
                  ),
                  retry: model.retry));
        });
  }

  _headWidget(TopicDetailModel topicDetailModel) {
    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              cacheImage(
                topicDetailModel.headerImage,
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Text(
                  topicDetailModel.text,
                  style: TextStyle(fontSize: 12, color: Color(0xff9a9a9a)),
                ),
              ),
              Container(
                height: 5,
                color: Colors.black12,
              )
            ],
          ),
          Positioned(
              left: 20,
              right: 20,
              top: 230,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    topicDetailModel.brief,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFF5F5F5)),
                      borderRadius: BorderRadius.circular(4))))
        ],
      ),
    );
  }
}

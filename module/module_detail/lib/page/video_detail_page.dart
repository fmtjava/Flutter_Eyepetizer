import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_core/widget/provider_widget.dart';
import 'package:lib_utils/event_bus.dart';
import 'package:lib_video/video_widget.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:lib_utils/date_util.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_common/event/watch_video_event.dart';
import 'package:module_common/model/common_item_model.dart';
import 'package:module_common/repository/history_repository.dart';
import 'package:module_common/widget/video_relate_widget_item.dart';
import 'package:module_detail/constant/string.dart';
import 'package:module_detail/viewmodel/video_detail_page_model.dart';
import 'package:module_detail/widget/appbar_widget.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {
  final Data videoDta;

  const VideoDetailPage({Key key, this.videoDta}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  final GlobalKey<VideoWidgetState> videoKey = GlobalKey();

  Data data;

  @override
  void initState() {
    super.initState();
    //监听页面可见与不可见状态
    data = widget.videoDta == null ? arguments() : widget.videoDta;
    WidgetsBinding.instance.addObserver(this);
    HistoryRepository.saveWatchHistory(data);
    Bus.getInstance().send(WatchVideoEvent());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //AppLifecycleState当前页面的状态(是否可见)
    if (state == AppLifecycleState.paused) {
      //页面不可见时,暂停视频
      videoKey.currentState.pause();
    } else if (state == AppLifecycleState.resumed) {
      videoKey.currentState.play();
    }
  }

  @override
  void dispose() {
    //移除监听页面可见与不可见状态
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoDetailPageModel>(
        model: VideoDetailPageModel(),
        onModelInit: (model) {
          model.loadVideoRelateData(data.id);
        },
        builder: (context, model, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
              child: Scaffold(
                  body: Column(children: <Widget>[
                _statusBar(),
                Hero(
                    //Hero动画
                    tag: '${data.id}${data.time}',
                    child: VideoWidget(
                      key: videoKey,
                      url: data.playUrl,
                      overlayUI: videoAppBar(),
                    )),
                Expanded(
                    flex: 1,
                    child: LoadingContainer(
                        viewState: model.viewState,
                        retry: model.retry,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    //背景图片
                                    fit: BoxFit.cover,
                                    image: cachedNetworkImageProvider(
                                        '${data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'))),
                            child: CustomScrollView(
                              //CustomScrollView结合Sliver可以防止滚动冲突
                              slivers: <Widget>[
                                SliverToBoxAdapter(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              data.title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                                '#${data.category} / ${formatDateMsByYMDHM(data.author.latestReleaseTime)}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12))),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10, right: 10),
                                            child: Text(data.description,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14))),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'images/ic_like.png',
                                                      height: 22,
                                                      width: 22,
                                                      package: 'module_detail',
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                      child: Text(
                                                        '${data.consumption.collectionCount}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                          'images/ic_share_white.png',
                                                          height: 22,
                                                          width: 22,
                                                          package:
                                                              'module_detail'),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                        child: Text(
                                                          '${data.consumption.shareCount}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                          'images/icon_comment.png',
                                                          height: 22,
                                                          width: 22,
                                                          package:
                                                              'module_detail'),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                        child: Text(
                                                          '${data.consumption.replyCount}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Divider(
                                                height: 0.5,
                                                color: Colors.white)),
                                        Row(children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: ClipOval(
                                                child: cacheImage(
                                                    data.author.icon,
                                                    height: 40,
                                                    width: 40),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(data.author.name,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white)),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3),
                                                      child: Text(
                                                          data.author
                                                              .description,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .white)))
                                                ],
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding: EdgeInsets.all(5),
                                                child: Text(add_follow,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 12))),
                                          ),
                                        ]),
                                        Divider(
                                            height: 0.5, color: Colors.white)
                                      ]),
                                ),
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                  if (model.itemList[index].type ==
                                      VIDEO_SMALL_CARD_TYPE) {
                                    return VideoRelateWidgetItem(
                                        data: model.itemList[index].data,
                                        callBack: () {
                                          videoKey.currentState.pause();
                                          toPage(VideoDetailPage(
                                              videoDta:
                                                  model.itemList[index].data));
                                        });
                                  }
                                  return Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        model.itemList[index].data.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ));
                                  //return
                                }, childCount: model.itemList.length))
                              ],
                            ))))
              ])),
              value: SystemUiOverlayStyle.light);
        });
  }

  _statusBar() {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: Colors.black,
    );
  }
}

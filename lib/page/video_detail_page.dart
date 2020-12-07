import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/chewie/chewie_player.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/provider/video_detail_page_model.dart';
import 'package:flutter_eyepetizer/repository/history_repository.dart';
import 'package:flutter_eyepetizer/util/date_util.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/video_relate_widget_item.dart';
import 'package:video_player/video_player.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

const VIDEO_HIGH = 'high';

class VideoDetailPage extends StatefulWidget {
  final Data data;
  final ChewieController chewieController; //无缝续播实现思路：共用列表传递过来的ChewieController

  const VideoDetailPage({Key key, @required this.data, this.chewieController})
      : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  VideoPlayerController _videoPlayerController;
  ChewieController _cheWieController;

  @override
  void initState() {
    super.initState();
    //监听页面可见与不可见状态
    WidgetsBinding.instance.addObserver(this);
    initController();
    HistoryRepository.saveWatchHistory(widget.data);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //AppLifecycleState当前页面的状态(是否可见)
    if (state == AppLifecycleState.paused) {
      //页面不可见时,暂停视频
      if (widget.chewieController == null) {
        _cheWieController.pause();
      } else {
        widget.chewieController.pause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (widget.chewieController == null) {
        _cheWieController.play();
      }
    }
  }

  @override
  void dispose() {
    //移除监听页面可见与不可见状态
    WidgetsBinding.instance.removeObserver(this);
    if (widget.chewieController == null) {
      _videoPlayerController.dispose();
      _cheWieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoDetailPageModel>(
        model: VideoDetailPageModel(),
        onModelInit: (model) {
          model.loadVideoRelateData(widget.data.id);
        },
        builder: (context, model, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
              child: Scaffold(
                  body: Column(children: <Widget>[
                Hero(
                    //Hero动画
                    tag: '${widget.data.id}${widget.data.time}',
                    child: Chewie(
                      controller: widget.chewieController ?? _cheWieController,
                    )),
                Expanded(
                    flex: 1,
                    child: LoadingContainer(
                        loading: model.loading,
                        error: model.error,
                        retry: model.retry,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    //背景图片
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        '${widget.data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'))),
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
                                              widget.data.title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                                '#${widget.data.category} / ${DateUtils.formatDateMsByYMDHM(widget.data.author.latestReleaseTime)}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12))),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10, right: 10),
                                            child: Text(widget.data.description,
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
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                      child: Text(
                                                        '${widget.data.consumption.collectionCount}',
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
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                        child: Text(
                                                          '${widget.data.consumption.shareCount}',
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
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                        child: Text(
                                                          '${widget.data.consumption.replyCount}',
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
                                                child: CachedNetworkImage(
                                                    imageUrl:
                                                        widget.data.author.icon,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            'images/img_load_fail.png'),
                                                    height: 40,
                                                    width: 40),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(widget.data.author.name,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white)),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3),
                                                      child: Text(
                                                          widget.data.author
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
                                                child: Text(DString.add_follow,
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
                                          if (widget.chewieController != null) {
                                            widget.chewieController.pause();
                                          } else {
                                            _videoPlayerController.pause();
                                          }
                                          NavigatorManager.to(VideoDetailPage(
                                              data:
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

  void initController() {
    if (widget.chewieController != null) return;
    List<PlayInfo> playInfoList = widget.data.playInfo;
    if (playInfoList.length > 1) {
      for (var playInfo in playInfoList) {
        if (playInfo.type == VIDEO_HIGH) {
          _videoPlayerController = VideoPlayerController.network(playInfo.url);
          _cheWieController = ChewieController(
              videoPlayerController: _videoPlayerController, autoPlay: true);
          break;
        }
      }
    } else {
      //若无高清视频，则取默认视频地址
      _videoPlayerController =
          VideoPlayerController.network(widget.data.playUrl);
      _cheWieController = ChewieController(
          videoPlayerController: _videoPlayerController, autoPlay: true);
    }
  }
}

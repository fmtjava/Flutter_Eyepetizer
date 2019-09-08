import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/model/issue_model.dart';
import 'package:flutter_eyepetizer/repository/video_repository.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/video_relate_widget_item.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final Item item;

  const VideoDetailPage({Key key, this.item}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  List<Item> itemList = [];
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //监听页面可见与不可见
    initChewieController();
    _loadVideoRelateData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chewieController.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                //背景图片
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    '${widget.item.data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'))),
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Expanded(
                flex: 1,
                child: LoadingContainer(
                    loading: _loading,
                    child: CustomScrollView(
                      //CustomScrollView结合Sliver可以防止滚动冲突
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      widget.item.data.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                        '#${widget.item.data.category} / ${DateUtil.formatDateMs(widget.item.data.author.latestReleaseTime, format: 'yyyy/MM/dd HH:mm')}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, top: 10, right: 10),
                                    child: Text(widget.item.data.description,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14))),
                                Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
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
                                              padding: EdgeInsets.only(left: 3),
                                              child: Text(
                                                '${widget.item.data.consumption.collectionCount}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: <Widget>[
                                              Image.asset(
                                                'images/ic_share_white.png',
                                                height: 22,
                                                width: 22,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 3),
                                                child: Text(
                                                  '${widget.item.data.consumption.shareCount}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: <Widget>[
                                              Image.asset(
                                                'images/icon_comment.png',
                                                height: 22,
                                                width: 22,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 3),
                                                child: Text(
                                                  '${widget.item.data.consumption.replyCount}',
                                                  style: TextStyle(
                                                      color: Colors.white,
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
                                        height: 0.5, color: Colors.white)),
                                Row(children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                widget.item.data.author.icon,
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
                                          Text(widget.item.data.author.name,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Text(
                                                  widget.item.data.author
                                                      .description,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white)))
                                        ],
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(5),
                                        child: Text('+ 关注',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 12))),
                                  ),
                                ]),
                                Divider(height: 0.5, color: Colors.white)
                              ]),
                        ),
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          if (itemList[index].type == 'videoSmallCard') {
                            return VideoRelateWidgetItem(
                                item: itemList[index],
                                callBack: () {
                                  _videoPlayerController.pause();
                                });
                          }
                          return Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                itemList[index].data.text,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ));
                          //return
                        }, childCount: itemList.length))
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  void _loadVideoRelateData() async {
    try {
      Issue issue =
          await VideoRepository.getVideoRelateList(widget.item.data.id);
      if (mounted) {
        setState(() {
          itemList = issue.itemList;
          _loading = false;
        });
      }
    } catch (e) {
      ToastUtil.showError(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  void initChewieController() {
    List<PlayInfo> playInfoList = widget.item.data.playInfo;
    if (playInfoList.length > 1) {
      for (var playInfo in playInfoList) {
        if (playInfo.type == 'high') {
          _videoPlayerController = VideoPlayerController.network(playInfo.url);
          _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController, autoPlay: true);
        }
      }
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/chewie/chewie_player.dart';
import 'package:flutter_eyepetizer/model/topic_detail_model.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/util/date_util.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:video_player/video_player.dart';

/// 目前列表视频滚动自动播放实现思路：
/// 1.NotificationListener监听列表在ScrollEndNotification时滚动的距离
/// 2.使用ValueNotifier保存滚动的距离并在每一个Item中进行滚动事件的监听/移除
/// 3.滚动的距离 / 列表Item的高度 计算出需要自动播放视频的Item,其它的Item暂时播放并显示视频封面
/// 4.点击指定Item的播放按钮时通过ValueNotifier告知其它Item进行暂停视频播放并显示视频封面
///
///
class FeedVideoWidget extends StatefulWidget {
  final TopicDetailItemData model;
  final ValueNotifier<double> scrollNotifier; //用于获取列表滚动的距离
  final ValueNotifier<int> playNotifier; //用于通知其它Item暂停视频播放并显示视频封面
  final int index; //对应列表的下标
  final double aspectRatio; //视频播放器显示的宽高比
  final GlobalKey listGlobalKey; //用于获取Item高度

  const FeedVideoWidget(
      {Key key,
      this.model,
      this.scrollNotifier,
      this.playNotifier,
      this.index,
      this.aspectRatio,
      this.listGlobalKey})
      : super(key: key);

  @override
  FeedVideoWidgetState createState() => FeedVideoWidgetState();
}

class FeedVideoWidgetState extends State<FeedVideoWidget>
    with WidgetsBindingObserver {
  bool _showFeed = true; //是否显示封面
  bool _start = false; //是否播放中
  double _itemHeight; //Item对应的高度
  double _pixels; //用于记录滚动的距离

  VideoPlayerController _videoPlayerController;
  ChewieController _cheWieController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _videoPlayerController =
        VideoPlayerController.network(widget.model.data.content.data.playUrl);
    _cheWieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoInitialize: true,
        looping: true,
        aspectRatio: widget.aspectRatio,
        initSuccessCallback: () {
          scrollListener(isResume: true);
        });
    widget.scrollNotifier.addListener(scrollListener);
    widget.playNotifier.addListener(playListener);
  }

  void scrollListener({bool isResume = false}) {
    if (!mounted) return;
    if (isResume) {
      //若是从后台回到前台，则播放之前暂停的视频
      if (_pixels != null) {
        _startPlay(_pixels);
      }
      return;
    }
    double pixels = widget.scrollNotifier.value;
    _pixels = pixels;
    _startPlay(pixels);
  }

  void _startPlay(double pixels) {
    if (_itemHeight == null) {
      _itemHeight = widget.listGlobalKey.currentContext
          .findRenderObject()
          .semanticBounds
          .size
          .height;
    }
    int position = pixels ~/ _itemHeight; //计算出需要自动播放视频的位置
    if (widget.index == position && _start) return;
    _changePlayState(position);
  }

  void playListener() {
    if (!mounted) return;
    int position = widget.playNotifier.value;
    if (position == -1) return;
    _changePlayState(position);
  }

  void _changePlayState(int position) {
    if (_cheWieController != null && widget.index == position) {
      if (!_cheWieController.videoPlayerController.value.initialized) {
        setState(() {
          _showFeed = false;
        });
        return;
      }
      if (!_start) {
        _start = true;
        _cheWieController.play().then((value) => {
              setState(() {
                _showFeed = false;
              })
            });
      }
    } else {
      if (!_cheWieController.videoPlayerController.value.initialized) {
        setState(() {
          _showFeed = true;
        });
        return;
      }
      if (_cheWieController != null && _start) {
        _start = false;
        _videoPlayerController.pause().then((value) => {
              setState(() {
                _showFeed = true;
              })
            });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _videoPlayerController.pause();
      _start = false;
      setState(() {
        _showFeed = true;
      });
    } else {
      scrollListener(isResume: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Stack(
        children: [
          Visibility(
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                      child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          imageUrl: widget.model.data.content.data.cover.feed,
                          errorWidget: (context, url, error) =>
                              Image.asset('images/img_load_fail.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(4)),
                  Positioned(
                      right: 8,
                      bottom: 8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.black54),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                DateUtils.formatDateMsByMS(
                                    widget.model.data.content.data.duration *
                                        1000),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )))),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 60,
                          ),
                          onPressed: () {
                            widget.playNotifier.value = -1;
                            widget.playNotifier.value = widget.index;
                          }),
                    ),
                  ),
                ],
                alignment: Alignment.center,
              ),
              visible: _showFeed),
          Visibility(
              child: ClipRRect(
                  child: Chewie(
                    controller: _cheWieController,
                    hideBackArrow: true,
                  ),
                  borderRadius: BorderRadius.circular(4)),
              visible: !_showFeed)
        ],
      ),
    );
  }

  void go2VideoDetailPage() {
    NavigatorManager.to(VideoDetailPage(
        data: widget.model.data.content.data,
        chewieController: _cheWieController));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController.dispose();
    _cheWieController.dispose();
    widget.scrollNotifier.removeListener(scrollListener);
    widget.playNotifier.removeListener(playListener);
    super.dispose();
  }
}

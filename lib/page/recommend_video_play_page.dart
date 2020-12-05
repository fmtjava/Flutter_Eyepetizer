import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/chewie/chewie_player.dart';
import 'package:flutter_eyepetizer/model/recommend_model.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';
import 'package:video_player/video_player.dart';

class RecommendVideoPlayPage extends StatefulWidget {
  final RecommendItem item;

  const RecommendVideoPlayPage({Key key, this.item}) : super(key: key);

  @override
  _RecommendVideoPlayPageState createState() => _RecommendVideoPlayPageState();
}

class _RecommendVideoPlayPageState extends State<RecommendVideoPlayPage>
    with WidgetsBindingObserver {
  VideoPlayerController _videoPlayerController;
  ChewieController _cheWieController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _videoPlayerController =
        VideoPlayerController.network(widget.item.data.content.data.playUrl);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _cheWieController.pause();
    } else if (state == AppLifecycleState.resumed) {
      _cheWieController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(
            children: <Widget>[
              Align(
                  child: Chewie(
                controller: _getCheWieController(),
                hideBackArrow: true,
              )),
              Positioned(
                  left: 10,
                  top: MediaQuery.of(context).padding.top + 10,
                  child: GestureDetector(
                    onTap: () => NavigatorManager.back(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ChewieController _getCheWieController() {
    double aspectRatio;
    bool allowFullScreen = widget.item.data.content.data.height >
        widget.item.data.content.data.width;
    if (allowFullScreen) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      aspectRatio = width / height;
    }
    _cheWieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: aspectRatio,
        autoPlay: true,
        looping: true,
        allowFullScreen: !allowFullScreen);
    return _cheWieController;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController.dispose();
    _cheWieController.dispose();
    super.dispose();
  }
}

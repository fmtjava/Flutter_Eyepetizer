import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eyepetizer/chewie/chewie_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class RecommendVideoPlayPage extends StatefulWidget {
  final String playUrl;

  const RecommendVideoPlayPage({Key key, @required this.playUrl})
      : super(key: key);

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
    _videoPlayerController = VideoPlayerController.network(widget.playUrl);
    _cheWieController = ChewieController(
        videoPlayerController: _videoPlayerController, autoPlay: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _cheWieController.pause();
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
              Positioned(
                  left: 10,
                  top: MediaQuery.of(context).padding.top + 10,
                  child: GestureDetector(
                    onTap: () => Get.back(),
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
              Align(
                  child: Chewie(
                controller: _cheWieController,
                hideBackArrow: true,
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _cheWieController.dispose();
    super.dispose();
  }
}

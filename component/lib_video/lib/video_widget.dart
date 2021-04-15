import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_utils/view_util.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

import 'customer_video_controls.dart';

//基于Chewie二次封装
class VideoWidget extends StatefulWidget {
  final String url;
  final bool autoPlay;
  final bool looping;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedChanging;
  final double aspectRatio;
  final Widget overlayUI;

  const VideoWidget(
      {Key key,
      this.url,
      this.autoPlay = true,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.allowFullScreen = true,
      this.allowPlaybackSpeedChanging = false,
      this.overlayUI})
      : super(key: key);

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _cheWieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _cheWieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        aspectRatio: widget.aspectRatio,
        allowPlaybackSpeedChanging: widget.allowPlaybackSpeedChanging,
        allowFullScreen: widget.allowFullScreen,
        customControls: MaterialControls(
          bottomGradient: blackLinearGradient(),
          overlayUI: widget.overlayUI,
        ));
    _cheWieController.addListener(_fullScreenListener);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width / widget.aspectRatio;
    return Container(
      width: width,
      height: height,
      child: Chewie(
        controller: _cheWieController,
      ),
    );
  }

  @override
  void dispose() {
    _cheWieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _cheWieController.dispose();
    super.dispose();
  }

  void play() {
    _cheWieController.play();
  }

  void pause() {
    _videoPlayerController.pause();
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      //使用Orientation插件解决ios全屏模式无法返回问题
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}

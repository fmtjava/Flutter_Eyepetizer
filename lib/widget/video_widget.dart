import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
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

  const VideoWidget(
      {Key key,
      this.url,
      this.autoPlay = true,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.allowFullScreen = true,
      this.allowPlaybackSpeedChanging = false})
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
          bottomGradient: bottomGradient(),
        ));
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

  //底部线性渐变
  bottomGradient({bool fromTop = false}) {
    return LinearGradient(
        begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
        end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
        colors: [
          Colors.black54,
          Colors.black45,
          Colors.black38,
          Colors.black26,
          Colors.black12,
          Colors.transparent
        ]);
  }
}

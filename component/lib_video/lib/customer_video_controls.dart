import 'dart:async';

import 'package:chewie/src/chewie_player.dart';
import 'package:chewie/src/chewie_progress_colors.dart';
import 'package:chewie/src/material/material_progress_bar.dart';
import 'package:chewie/src/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

///自定义播放器UI
class MaterialControls extends StatefulWidget {
  final bool showLoadingOnInitialize;

  final bool showBigPlayIcon;

  final Widget overlayUI;

  final Gradient bottomGradient;

  const MaterialControls(
      {Key key,
      this.showLoadingOnInitialize = true,
      this.showBigPlayIcon = true,
      this.overlayUI,
      this.bottomGradient})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MaterialControlsState();
  }
}

class _MaterialControlsState extends State<MaterialControls>
    with SingleTickerProviderStateMixin {
  VideoPlayerValue _latestValue;
  double _latestVolume;
  bool _hideStuff = true;
  Timer _hideTimer;
  Timer _initTimer;
  Timer _showAfterExpandCollapseTimer;
  bool _dragging = false;
  bool _displayTapped = false;

  final barHeight = 48.0;
  final marginSize = 5.0;

  VideoPlayerController controller;
  ChewieController chewieController;
  AnimationController playPauseIconAnimationController;

  @override
  Widget build(BuildContext context) {
    if (_latestValue.hasError) {
      return chewieController.errorBuilder != null
          ? chewieController.errorBuilder(
              context,
              chewieController.videoPlayerController.value.errorDescription,
            )
          : const Center(
              child: Icon(
                Icons.error,
                color: Colors.white,
                size: 42,
              ),
            );
    }

    return MouseRegion(
      onHover: (_) {
        _cancelAndRestartTimer();
      },
      child: GestureDetector(
        onTap: () => _cancelAndRestartTimer(),
        child: AbsorbPointer(
          absorbing: _hideStuff,
          child: Stack(
            children: [
              Container(),
              Column(
                children: <Widget>[
                  if (_latestValue != null &&
                          !_latestValue.isPlaying &&
                          _latestValue.duration == null ||
                      _latestValue.isBuffering)
                    Expanded(
                      child: Center(
                        child: _loadingIndicator(),
                      ),
                    )
                  else
                    _buildHitArea(),
                  _buildBottomBar(context),
                ],
              ),
              _overlayUI()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _initTimer?.cancel();
    _showAfterExpandCollapseTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = chewieController;
    chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    playPauseIconAnimationController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );

    if (_oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  ///底部控制栏
  AnimatedOpacity _buildBottomBar(
    BuildContext context,
  ) {
    final iconColor = Theme.of(context).textTheme.button.color;

    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
            //渐变
            gradient: widget.bottomGradient),
        child: Row(
          children: <Widget>[
            _buildPlayPause(controller),
            if (chewieController.isLive)
              const SizedBox()
            else
              _buildProgressBar(),
            if (chewieController.isLive)
              const Expanded(child: Text('LIVE'))
            else
              _buildPosition(iconColor),
            if (chewieController.allowPlaybackSpeedChanging)
              _buildSpeedButton(controller),
            if (chewieController.allowMuting) _buildMuteButton(controller),
            if (chewieController.allowFullScreen) _buildExpandButton(),
          ],
        ),
      ),
    );
  }

  ///展开按钮
  GestureDetector _buildExpandButton() {
    return GestureDetector(
      onTap: _onExpandCollapse,
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: barHeight,
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Center(
            child: Icon(
              chewieController.isFullScreen
                  ? Icons.fullscreen_exit_rounded
                  : Icons.fullscreen_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildHitArea() {
    final bool isFinished = _latestValue.position >= _latestValue.duration;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_latestValue != null && _latestValue.isPlaying) {
            if (_displayTapped) {
              setState(() {
                _hideStuff = true;
              });
            } else {
              _cancelAndRestartTimer();
            }
          } else {
            //防止点击空白区域有暂停变成了播放
            // _playPause();

            setState(() {
              _hideStuff = true;
            });
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: AnimatedOpacity(
              opacity:
                  _latestValue != null && !_latestValue.isPlaying && !_dragging
                      ? 1.0
                      : 0.0,

              ///中间播放按钮
              duration: const Duration(milliseconds: 300),
              child: widget.showBigPlayIcon
                  ? GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dialogBackgroundColor,
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Material(
                            child: IconButton(
                                icon: isFinished
                                    ? const Icon(Icons.replay, size: 32.0)
                                    : AnimatedIcon(
                                        icon: AnimatedIcons.play_pause,
                                        progress:
                                            playPauseIconAnimationController,
                                        size: 32.0,
                                      ),
                                onPressed: () {
                                  _playPause();
                                }),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedButton(
    VideoPlayerController controller,
  ) {
    return GestureDetector(
      onTap: () async {
        _hideTimer?.cancel();

        final chosenSpeed = await showModalBottomSheet<double>(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          builder: (context) => _PlaybackSpeedDialog(
            speeds: chewieController.playbackSpeeds,
            selected: _latestValue.playbackSpeed,
          ),
        );

        if (chosenSpeed != null) {
          controller.setPlaybackSpeed(chosenSpeed);
        }

        if (_latestValue.isPlaying) {
          _startHideTimer();
        }
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: ClipRect(
          child: Container(
            height: barHeight,
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: const Icon(Icons.speed),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildMuteButton(
    VideoPlayerController controller,
  ) {
    return GestureDetector(
      onTap: () {
        _cancelAndRestartTimer();

        if (_latestValue.volume == 0) {
          controller.setVolume(_latestVolume ?? 0.5);
        } else {
          _latestVolume = controller.value.volume;
          controller.setVolume(0.0);
        }
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: ClipRect(
          child: Container(
            height: barHeight,
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Icon(
              (_latestValue != null && _latestValue.volume > 0)
                  ? Icons.volume_up
                  : Icons.volume_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  ///暂停和播放icon
  GestureDetector _buildPlayPause(VideoPlayerController controller) {
    return GestureDetector(
      onTap: _playPause,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: Icon(
          controller.value.isPlaying
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  ///播放时间
  Widget _buildPosition(Color iconColor) {
    final position = _latestValue != null && _latestValue.position != null
        ? _latestValue.position
        : Duration.zero;
    final duration = _latestValue != null && _latestValue.duration != null
        ? _latestValue.duration
        : Duration.zero;

    return Padding(
      padding: EdgeInsets.only(right: 5.0),
      child: Text(
        '${formatDuration(position)}/${formatDuration(duration)}',
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();

    setState(() {
      _hideStuff = false;
      _displayTapped = true;
    });
  }

  Future<void> _initialize() async {
    controller.addListener(_updateState);

    _updateState();

    if ((controller.value != null && controller.value.isPlaying) ||
        chewieController.autoPlay) {
      _startHideTimer();
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          _hideStuff = false;
        });
      });
    }
  }

  void _onExpandCollapse() {
    if (chewieController.videoPlayerController.value.size == null) {
      print('_onExpandCollapse:videoPlayerController.value.size is null.');
      return;
    }
    setState(() {
      _hideStuff = true;

      chewieController.toggleFullScreen();
      _showAfterExpandCollapseTimer =
          Timer(const Duration(milliseconds: 300), () {
        setState(() {
          _cancelAndRestartTimer();
        });
      });
    });
  }

  void _playPause() {
    bool isFinished;
    if (_latestValue.duration != null) {
      isFinished = _latestValue.position >= _latestValue.duration;
    } else {
      isFinished = false;
    }

    setState(() {
      if (controller.value.isPlaying) {
        playPauseIconAnimationController.reverse();
        _hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
      } else {
        _cancelAndRestartTimer();

        if (!controller.value.isInitialized) {
          controller.initialize().then((_) {
            controller.play();
            playPauseIconAnimationController.forward();
          });
        } else {
          if (isFinished) {
            controller.seekTo(const Duration());
          }
          playPauseIconAnimationController.forward();
          controller.play();
        }
      }
    });
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _updateState() {
    setState(() {
      _latestValue = controller.value;
    });
  }

  ///进度条
  Widget _buildProgressBar() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 15, left: 15),
        child: MaterialVideoProgressBar(
          controller,
          onDragStart: () {
            setState(() {
              _dragging = true;
            });

            _hideTimer?.cancel();
          },
          onDragEnd: () {
            setState(() {
              _dragging = false;
            });

            _startHideTimer();
          },
          colors: chewieController.materialProgressColors ??
              ChewieProgressColors(
                  playedColor: Theme.of(context).colorScheme.secondary,
                  handleColor: Theme.of(context).colorScheme.secondary,
                  bufferedColor: Theme.of(context).backgroundColor,
                  backgroundColor: Theme.of(context).disabledColor),
        ),
      ),
    );
  }

  ///中间进度条
  _loadingIndicator() {
    //初始化时是否显示loading
    return widget.showLoadingOnInitialize ? CircularProgressIndicator() : null;
  }

  ///浮层
  _overlayUI() {
    return widget.overlayUI != null
        ? AnimatedOpacity(
            opacity: _hideStuff ? 0.0 : 1.0,
            duration: Duration(milliseconds: 300),
            child: widget.overlayUI)
        : Container();
  }
}

class _PlaybackSpeedDialog extends StatelessWidget {
  const _PlaybackSpeedDialog({
    Key key,
    @required List<double> speeds,
    @required double selected,
  })  : _speeds = speeds,
        _selected = selected,
        super(key: key);

  final List<double> _speeds;
  final double _selected;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Theme.of(context).primaryColor;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        final _speed = _speeds[index];
        return ListTile(
          dense: true,
          title: Row(
            children: [
              if (_speed == _selected)
                Icon(
                  Icons.check,
                  size: 20.0,
                  color: selectedColor,
                )
              else
                Container(width: 20.0),
              const SizedBox(width: 16.0),
              Text(_speed.toString()),
            ],
          ),
          selected: _speed == _selected,
          onTap: () {
            Navigator.of(context).pop(_speed);
          },
        );
      },
      itemCount: _speeds.length,
    );
  }
}

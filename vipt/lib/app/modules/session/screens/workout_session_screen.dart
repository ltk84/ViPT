import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/modules/session/session_controller.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';

class WorkoutSession extends StatefulWidget {
  WorkoutSession({Key? key}) : super(key: key);

  @override
  State<WorkoutSession> createState() => _WorkoutSessionState();
}

class _WorkoutSessionState extends State<WorkoutSession> {
  final _controller = Get.find<SessionController>();
  VideoPlayerController? _videoController;
  bool isInitVideo = false;

  @override
  void initState() {
    _initVideoController(_controller.currentWorkout.animation);
    super.initState();
  }

  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }

  void _initVideoController(String link) async {
    // var link = _controller.currentWorkout.animation;
    isInitVideo = true;
    if (_videoController == null) {
      _videoController = VideoPlayerController.network(link)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            _videoController!.setLooping(true);
            isInitVideo = false;
            // _videoController!.play();
          });
        });
    } else {
      final oldController = _videoController;
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        await oldController!.dispose();

        _videoController = VideoPlayerController.network(link)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {
              _videoController!.setLooping(true);
              isInitVideo = false;
              // _videoController!.play();
            });
          });
      });

      setState(() {
        _videoController = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Tên bộ luyện tập'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).backgroundColor,
            icon: Hero(
              tag: 'actionButtonAppBar',
              child: Icon(
                Icons.settings_rounded,
                color: AppColor.textColor,
              ),
            ),
            onPressed: () async {},
          ),
        ],
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding:
                    AppDecoration.screenPadding.copyWith(top: 8, bottom: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColor.textFieldUnderlineColor,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    _buildInfoSection(context),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth,
                          ),
                          child: _buildMediaPlayer(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildActionSection(context),
            // MyCircularCountDownTimer(
            //   duration: _controller.timeValue.minutes.inSeconds,
            //   initialDuration: 0,
            //   controller: _controller.collectionTimeController,
            //   width: 100,
            //   height: 100,
            //   ringColor: Colors.grey,
            //   ringGradient: null,
            //   fillColor: Colors.purpleAccent,
            //   fillGradient: null,
            //   backgroundColor: Colors.orange[500],
            //   backgroundGradient: null,
            //   strokeWidth: 20.0,
            //   strokeCap: StrokeCap.round,
            //   textStyle: const TextStyle(
            //       fontSize: 33.0,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold),
            //   textFormat: MyCountdownTextFormat.MM_SS,
            //   isReverse: true,
            //   isReverseAnimation: false,
            //   isTimerTextShown: true,
            //   autoStart: false,
            //   onStart: () {},
            //   onComplete: () {},
            // ),
            // MyCircularCountDownTimer(
            //   duration: _controller.timeList[0],
            //   initialDuration: 0,
            //   controller: _controller.workoutTimeController,
            //   width: 100,
            //   height: 100,
            //   ringColor: Colors.grey,
            //   ringGradient: null,
            //   fillColor: Colors.purpleAccent,
            //   fillGradient: null,
            //   backgroundColor: Colors.orange[500],
            //   backgroundGradient: null,
            //   strokeWidth: 20.0,
            //   strokeCap: StrokeCap.round,
            //   textStyle: const TextStyle(
            //       fontSize: 33.0,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold),
            //   textFormat: MyCountdownTextFormat.S,
            //   isReverse: true,
            //   isReverseAnimation: false,
            //   isTimerTextShown: true,
            //   autoStart: false,
            //   onStart: () {},
            //   onComplete: () {
            //     onTimerComplete();
            //   },
            // ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         start();
            //       },
            //       child: Text('Bắt đầu'.tr,
            //           style: Theme.of(context).textTheme.button),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         pause();
            //       },
            //       child: Text('Tạm dừng'.tr,
            //           style: Theme.of(context).textTheme.button),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         resume();
            //       },
            //       child: Text('Tiếp tục'.tr,
            //           style: Theme.of(context).textTheme.button),
            //     ),
            //     ElevatedButton(
            //       onPressed: isInitVideo
            //           ? null
            //           : () {
            //               skip();
            //             },
            //       child: Text('Bỏ qua'.tr,
            //           style: Theme.of(context).textTheme.button),
            //     ),
            //   ],
            // )
          ],
        );
      }),
    );
  }

  void onTimerComplete() {
    _videoController!.pause();

    _controller.onWorkoutTimerComplete();
    if (_controller.isWorkoutTurn) {
      setState(() {
        _videoController!.play();
      });
    } else if (_controller.isTransitionTurn) {
      _initVideoController(_controller.currentWorkout.animation);
    } else {
      _videoController!.pause();
    }
  }

  void start() {
    _controller.start();
    if (_controller.isWorkoutTurn) {
      _videoController!.play();
    }
  }

  void pause() {
    _controller.pause();
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
    }
  }

  void resume() {
    _controller.resume();
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
    }
  }

  void skip() {
    _videoController!.pause();
    _controller.skip();
    setState(() {
      // print(_videoController!.value.isInitialized);
      _initVideoController(_controller.currentWorkout.animation);
      // _videoController!.play();
    });
  }

  Widget _buildMediaPlayer() {
    if (_videoController == null) {
      return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.textFieldFill,
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: VideoPlayer(_videoController as VideoPlayerController),
    );
  }

  Widget _buildInfoSection(context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InkWell(
                onTap: null,
                child: Icon(Icons.info_rounded, color: Colors.transparent),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                _controller.currentWorkout.name,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                width: 8,
              ),
              Material(
                shape: const CircleBorder(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {},
                  child: const Icon(
                    Icons.info_rounded,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '3 trên 5',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: AppColor.textColor),
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 28,
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color getStatusColorForFill() {
    switch (_controller.status) {
      case TimerStatus.play:
        return AppColor.workoutTimerPlayingFill;
      case TimerStatus.pause:
        return AppColor.workoutTimerStopFill;
      case TimerStatus.rest:
        return AppColor.workoutTimerRestFill;
      default:
        return AppColor.workoutTimerReadyFill;
    }
  }

  Color getStatusColorForIndicator() {
    switch (_controller.status) {
      case TimerStatus.play:
        return AppColor.workoutTimerPlayingIndicatorColor;
      case TimerStatus.pause:
        return AppColor.workoutTimerStopIndicatorColor;
      case TimerStatus.rest:
        return AppColor.workoutTimerRestIndicatorColor;
      default:
        return AppColor.workoutTimerReadyIndicatorColor;
    }
  }

  Widget _buildActionSection(context) {
    Color indicatorColor = AppColor.workoutTimerPlayingIndicatorColor;
    Color fillColor = AppColor.workoutTimerPlayingFill;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 48,
            color: AppColor.mediaButtonColor,
            icon: const Icon(Icons.pause_circle_filled_rounded),
            onPressed: () {},
          ),
          MyCircularCountDownTimer(
            duration: _controller.timeList[0],
            initialDuration: 0,
            controller: _controller.workoutTimeController,
            width: 104,
            height: 104,
            ringColor: AppColor.timerRingColor,
            fillColor: fillColor,
            backgroundColor: Colors.transparent,
            strokeWidth: 8.0,
            strokeCap: StrokeCap.round,
            textFormat: MyCountdownTextFormat.S,
            textStyle: Theme.of(context).textTheme.headline2,
            isReverse: true,
            isReverseAnimation: false,
            autoStart: false,
            indicatorWidth: 8,
            indicatorColor: indicatorColor,
            isTimerTextShown: true,
            onStart: () {},
            onComplete: () {
              onTimerComplete();
            },
            childWidget: _buildCollectionTimer(),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 48,
            color: AppColor.mediaButtonColor,
            icon: const Icon(Icons.skip_next_rounded),
            onPressed: () {},
          ),
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   iconSize: 48,
          //   color: AppColor.mediaButtonColor,
          //   icon: const Icon(Icons.play_circle_fill_rounded),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }

  Widget _buildCollectionTimer() {
    return MyCircularCountDownTimer(
      duration: _controller.timeValue.minutes.inSeconds,
      initialDuration: 0,
      controller: _controller.collectionTimeController,
      width: 40,
      height: 40,
      ringColor: AppColor.timerRingColor,
      fillColor: AppColor.collectionTimerFill,
      backgroundColor: AppColor.collectionTimerBackgroundColor,
      strokeWidth: 2.0,
      strokeCap: StrokeCap.round,
      textFormat: MyCountdownTextFormat.MM_SS,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10),
      isReverse: true,
      isReverseAnimation: false,
      autoStart: false,
      onStart: () {},
      onComplete: () {},
      indicatorColor: AppColor.collectionTimerIndicatorColor,
      indicatorWidth: 4,
    );
  }
}

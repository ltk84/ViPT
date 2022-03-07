import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vipt/app/core/values/colors.dart';
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
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: _buildMediaPlayer(),
          ),
          MyCircularCountDownTimer(
            duration: _controller.timeValue.minutes.inSeconds,
            initialDuration: 0,
            controller: _controller.collectionTimeController,
            width: 100,
            height: 100,
            ringColor: Colors.grey,
            ringGradient: null,
            fillColor: Colors.purpleAccent,
            fillGradient: null,
            backgroundColor: Colors.orange[500],
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: MyCountdownTextFormat.MM_SS,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {},
            onComplete: () {
              print('calo: ' + _controller.caloConsumed.toString());
              print('time: ' + _controller.timeConsumed.toString());
            },
          ),
          MyCircularCountDownTimer(
            duration: _controller.timeList[0],
            initialDuration: 0,
            controller: _controller.workoutTimeController,
            width: 100,
            height: 100,
            ringColor: Colors.grey,
            ringGradient: null,
            fillColor: Colors.purpleAccent,
            fillGradient: null,
            backgroundColor: Colors.orange[500],
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: MyCountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {},
            onComplete: () {
              onTimerComplete();
            },
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  start();
                },
                child: Text('Bắt đầu'.tr,
                    style: Theme.of(context).textTheme.button),
              ),
              ElevatedButton(
                onPressed: () {
                  pause();
                },
                child: Text('Tạm dừng'.tr,
                    style: Theme.of(context).textTheme.button),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  resume();
                },
                child: Text('Tiếp tục'.tr,
                    style: Theme.of(context).textTheme.button),
              ),
              ElevatedButton(
                onPressed: isInitVideo
                    ? null
                    : () {
                        skip();
                      },
                child: Text('Bỏ qua'.tr,
                    style: Theme.of(context).textTheme.button),
              ),
            ],
          )
        ],
      ),
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
}

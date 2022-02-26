import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/session/session_controller.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';

class WorkoutSession extends StatelessWidget {
  WorkoutSession({Key? key}) : super(key: key);

  final _controller = Get.find<SessionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyCircularCountDownTimer(
              duration: _controller.timeValue.toInt().minutes.inSeconds,
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
              onStart: () {
                print('Countdown Started');
              },
              onComplete: () {
                print('Countdown Ended');
              },
            ),
            MyCircularCountDownTimer(
              duration: _controller.collectionSetting.exerciseTime,
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
              onStart: () {
                print('Countdown Started');
              },
              onComplete: () {
                print('Countdown Ended');
                _controller.onWorkoutTimerComplete();
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.start();
                  },
                  child: Text('Bắt đầu'.tr,
                      style: Theme.of(context).textTheme.button),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.pause();
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
                    _controller.resume();
                  },
                  child: Text('Tiếp tục'.tr,
                      style: Theme.of(context).textTheme.button),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.skip();
                  },
                  child: Text('Bỏ qua'.tr,
                      style: Theme.of(context).textTheme.button),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/session/session_controller.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';

class WorkoutSession extends StatelessWidget {
  WorkoutSession({Key? key}) : super(key: key);

  final _controller = Get.find<SessionController>();

  final countController = MyCountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            MyCircularCountDownTimer(
              duration: 10,
              initialDuration: 0,
              controller: countController,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
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
              isTimerTextShown: false,
              autoStart: false,
              onStart: () {
                print('Countdown Started');
              },
              onComplete: () {
                print('Countdown Ended');
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Get.toNamed(Routes.setupInfoQuestion);
                countController.start();
              },
              child:
                  Text('Bắt đầu'.tr, style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}

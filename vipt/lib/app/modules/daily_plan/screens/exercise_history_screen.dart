import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/history_tile.dart';
import 'package:vipt/app/modules/daily_plan/widgets/input_amount_dialog.dart';

import '../daily_exercise_controller.dart';

class ExerciseHistoryScreen extends StatelessWidget {
  ExerciseHistoryScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DailyExerciseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.exerciseBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 20,
          color: Theme.of(context).backgroundColor,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.accentTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Lịch sử luyện tập',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: AppColor.accentTextColor,
              ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Column(
            children: [
              _buildInfo(context, _controller),
              _buildHistoryList(context),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _buildActionButton(context, _controller),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildInfo(context, DailyExerciseController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Hero(
        tag: 'exerciseIntakeWidget',
        child: Obx(
          () => GoalProgressIndicator(
            radius: screenWidth * 0.3,
            value: controller.calories.value,
            unitString: 'calories tiêu hao',
          ),
        ),
      ),
    );
  }

  _buildHistoryList(context) {
    return GetBuilder<DailyExerciseController>(builder: (c) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 36,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Row(
                children: [
                  Text(
                    'Lịch sử',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: AppColor.accentTextColor,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            ...c.tracks.map((log) {
              log as ExerciseTracker;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: HistoryTile(
                  title: 'Luyện tập',
                  description: log.toString() + 'ml',
                  date: '${log.date.day}/${log.date.month}/${log.date.year}',
                  time: '${log.date.hour}:${log.date.minute}',
                  action: () {
                    //c.deleteTrack(log);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      );
    });
  }

  _buildActionButton(context, DailyExerciseController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24,
      ),
      child: ScaleTap(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return InputAmountDialog(
                title: 'Calories đã đốt cháy',
                unit: 'kcal',
                value: 200,
                confirmButtonColor: AppColor.exerciseBackgroundColor,
                confirmButtonText: 'Thêm',
                sliderActiveColor: AppColor.exerciseBackgroundColor,
                sliderInactiveColor:
                    AppColor.exerciseBackgroundColor.withOpacity(
                  AppColor.subTextOpacity,
                ),
              );
            },
          );

          if (result != null) {
            await _controller.addTrack(result);
          }
        },
        child: SvgPicture.asset(
          SVGAssetString.heartOnFire,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}

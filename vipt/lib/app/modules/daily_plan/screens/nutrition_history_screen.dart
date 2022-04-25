import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/tracker.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/modules/daily_plan/daily_nutrition_controller.dart';
import 'package:vipt/app/modules/daily_plan/screens/log_food_screen.dart';
import 'package:vipt/app/modules/daily_plan/widgets/history_tile.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';

class NutritionHistoryScreen extends StatelessWidget {
  NutritionHistoryScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DailyNutritionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.nutriBackgroundColor,
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
          'Lịch sử dinh dưỡng',
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
              Obx(() =>
                  _buildInfo(context, intake: _controller.intakeCalo.value)),
              Obx(() => _buildNutritionFacts(
                    carbs: _controller.carbs.value,
                    fat: _controller.fat.value,
                    protein: _controller.protein.value,
                  )),
              _buildHistoryList(context, _controller.tracks),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _buildActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildInfo(context, {int intake = 0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Hero(
        tag: 'caloriesIntakeWidget',
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 6, color: AppColor.accentTextColor),
              ),
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
            ),
            SizedBox(
              width: screenWidth * 0.3,
              child: VerticalInfoWidget(
                title: intake.toString(),
                subtitle: 'calories hấp thụ',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildNutritionFacts({int carbs = 0, int protein = 0, int fat = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Hero(
        tag: 'nutritionFactWidget',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FittedBox(
              child: SizedBox(
                height: 80,
                child: InfoCubeWidget(
                  width: 90,
                  height: 90,
                  title: carbs.toString(),
                  subtitle: 'Carbs',
                  color: AppColor.carbCubeColor,
                  textColor: AppColor.buttonForegroundColor,
                  borderColor: AppColor.buttonForegroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            FittedBox(
              child: SizedBox(
                height: 80,
                child: InfoCubeWidget(
                  width: 90,
                  height: 90,
                  title: protein.toString(),
                  subtitle: 'Protein',
                  color: AppColor.proteinCubeColor,
                  textColor: AppColor.buttonForegroundColor,
                  borderColor: AppColor.buttonForegroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            FittedBox(
              child: SizedBox(
                height: 80,
                child: InfoCubeWidget(
                  width: 90,
                  height: 90,
                  title: fat.toString(),
                  subtitle: 'Fat',
                  color: AppColor.fatCubeColor,
                  textColor: AppColor.buttonForegroundColor,
                  borderColor: AppColor.buttonForegroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHistoryList(
    context,
    List<Tracker> nutritionHistory,
  ) {
    return GetBuilder<DailyNutritionController>(builder: (c) {
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
            ...nutritionHistory.map((log) {
              log as MealNutritionTracker;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: HistoryTile(
                  title: log.name,
                  description: log.intakeCalories.toString(),
                  date: '${log.date.day}/${log.date.month}/${log.date.year}',
                  time: '${log.date.hour}:${log.date.minute}',
                  action: () async {
                    await c.deleteTrack(log);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      );
    });
  }

  _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: ScaleTap(
        onPressed: () {
          Get.bottomSheet(
            Container(
              margin: const EdgeInsets.only(top: 48),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: LogFoodScreen(),
              ),
            ),
            isScrollControlled: true,
          );
        },
        child: SvgPicture.asset(
          SVGAssetString.nutritionHeart,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}

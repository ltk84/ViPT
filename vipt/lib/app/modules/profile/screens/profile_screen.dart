import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/modules/profile/widgets/progress_image_widget.dart';
import 'package:vipt/app/modules/profile/widgets/weekly_exercise_widget.dart';
import 'package:vipt/app/modules/profile/widgets/weekly_nutrition_widget.dart';
import 'package:vipt/app/modules/profile/widgets/weekly_step_widget.dart';
import 'package:vipt/app/modules/profile/widgets/weekly_water_widget.dart';
import 'package:vipt/app/modules/profile/widgets/weight_tracking_widget.dart';
import 'package:vipt/app/routes/pages.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          AppBarIconButton(
            iconData: Icons.settings_rounded,
            onPressed: () {
              Get.toNamed(Routes.setting);
            },
            hero: 'settingButton',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(JPGAssetString.userWorkoutCollection),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: bodyHeight * 0.05,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: bodyHeight * 0.86),
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                child: Text(
                                  'Quá trình của bạn',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: AppColor.textColor,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                              WeeklyExerciseWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                              WeeklyNutritionWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                              WeeklyWaterWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                              WeeklyStepWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                              Obx(
                                () => WeightTrackingWidget(
                                  weighTracks: _controller.weightTrackList,
                                  handleChangeTimeRange:
                                      _controller.changeWeighDateRange,
                                  timeRange: _controller.weightDateRange.value,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                              ProgressImageWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Divider(
                                  color: AppColor.textFieldUnderlineColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

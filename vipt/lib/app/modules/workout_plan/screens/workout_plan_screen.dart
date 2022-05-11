import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/daily_plan/widgets/collection_tab_holder.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';
import 'package:vipt/app/modules/workout_plan/widgets/progress_info_widget.dart';
import 'package:vipt/app/modules/workout_plan/widgets/shortcut_button.dart';
import 'package:vipt/app/modules/workout_plan/widgets/weight_info_widget.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: AppColor.exerciseBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 8,
              ),
              Text(
                'Lộ trình tập luyện',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: bodyHeight * 0.35),
                child: Column(
                  children: [
                    _buildInfo(context),
                    const SizedBox(
                      height: 24,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: WeightInfoWidget(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: ProgressInfoWidget(
                        completeDays: [
                          true,
                          true,
                          true,
                          true,
                          true,
                          true,
                          true,
                          true,
                          true,
                          true,
                          false
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Flexible(
                    //       child: ShortcutButton(
                    //         onPressed: () {},
                    //         title: 'Theo dõi luyện tập',
                    //         icon: SvgPicture.asset(
                    //           SVGAssetString.shortcutExercise,
                    //           height: 28,
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: ShortcutButton(
                    //         onPressed: () {},
                    //         title: 'Theo dõi dinh dưỡng',
                    //         icon: SvgPicture.asset(
                    //           SVGAssetString.shortcutNutrition,
                    //           height: 28,
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: ShortcutButton(
                    //         onPressed: () {},
                    //         title: 'Theo dõi nước uống',
                    //         icon: SvgPicture.asset(
                    //           SVGAssetString.shortcutWater,
                    //           height: 28,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Flexible(
                    //       child: ShortcutButton(
                    //         onPressed: () {},
                    //         title: 'Xem thống kê',
                    //         icon: SvgPicture.asset(
                    //           SVGAssetString.shortcutStatistics,
                    //           height: 28,
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: ShortcutButton(
                    //         onPressed: () {},
                    //         title: 'Hình ảnh quá trình',
                    //         icon: SvgPicture.asset(
                    //           SVGAssetString.shortcutProgressImage,
                    //           height: 28,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: bodyHeight * 0.65),
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
                        Text(
                          "LUYỆN TẬP".tr,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColor.textFieldUnderlineColor,
                        ),
                        const SizedBox(
                          height: 8,
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
    );
  }

  _buildInfo(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: screenWidth * 0.3,
          child: const VerticalInfoWidget(
            title: '2074',
            subtitle: 'hấp thụ',
          ),
        ),
        GoalProgressIndicator(
          radius: screenWidth * 0.3,
          title: '1460',
          subtitle: 'calories',
          progressValue: 0.5,
        ),
        SizedBox(
          width: screenWidth * 0.3,
          child: const VerticalInfoWidget(
            title: '614',
            subtitle: 'tiêu hao',
          ),
        ),
      ],
    );
  }
}

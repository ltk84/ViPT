import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/daily_plan/daily_exercise_controller.dart';
import 'package:vipt/app/modules/daily_plan/widgets/collection_tab_holder.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/input_amount_dialog.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';

class DailyExerciseScreen extends StatelessWidget {
  DailyExerciseScreen({Key? key}) : super(key: key);

  final _controller = Get.put(DailyExerciseController());

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;
    List<String> tabs = [
      'Dinh dưỡng',
      'Luyện tập',
      'Nước',
      'Bước chân',
      'Fasting',
    ];

    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: AppColor.exerciseBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            int? newIndex;
            await _showTabSelection(context, items: tabs, value: 1,
                onSelectedItemChanged: (value) {
              newIndex = value;
            });
            if (newIndex != null) {
              _controller.changeTab(newIndex ?? 0);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 8,
              ),
              Text(
                tabs[1].tr,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.accentTextColor,
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              var dateTime = await showDatePicker(
                  locale: const Locale("vi", "VI"),
                  context: context,
                  initialDate: _controller.date,
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now());
              if (dateTime != null) {
                _controller.fetchTracksByDate(dateTime);
              }
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColor.accentTextColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Hôm nay'.tr,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColor.accentTextColor,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(
                  width: 24,
                ),
              ],
            ),
          ),
        ],
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
                child: _buildInfo(context, _controller),
              ),
              _buildActionButton(context),
              _buildActionDescription(context),
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
                        CollectionTabHolder(
                            firstCollection:
                                DataService.instance.collectionList,
                            secondCollection:
                                DataService.instance.userCollectionList),
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

  _buildInfo(context, DailyExerciseController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: screenWidth * 0.3,
            child: VerticalInfoWidget(
              title: controller.sessions.value.toString(),
              subtitle: 'phiên tập',
            ),
          ),
          GoalProgressIndicator(
            radius: screenWidth * 0.3,
            value: controller.calories.value,
            unitString: 'calories tiêu hao',
          ),
          SizedBox(
            width: screenWidth * 0.3,
            child: VerticalInfoWidget(
              title: controller.time / 60 < 1
                  ? controller.time.toInt().toString()
                  : (controller.time.value / 60).ceil().toString(),
              subtitle: controller.time / 60 < 1 ? 'giây' : 'phút',
            ),
          ),
        ],
      ),
    );
  }

  _buildActionButton(context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
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
        ),
      ),
    );
  }

  _buildActionDescription(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 24),
      child: Text(
        'Chạm vào trái tim màu đỏ để cập nhật lượng calories đã đốt cháy.',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: AppColor.accentTextColor,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _showTabSelection(context,
      {required List<String> items,
      required Function(int)? onSelectedItemChanged,
      required int value}) async {
    await showDialog(
      useRootNavigator: false,
      //isScrollControlled: true,
      //backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      //elevation: 0.0,
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder<double>(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            tween: Tween(begin: 0, end: 7),
            builder: (_, blurValue, __) {
              return ClipRect(
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: AnimatedOpacity(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 300),
                      opacity: blurValue / 7,
                      child: CupertinoPicker.builder(
                        onSelectedItemChanged: onSelectedItemChanged,
                        backgroundColor: Colors.transparent,
                        itemExtent: 48,
                        scrollController:
                            FixedExtentScrollController(initialItem: value),
                        childCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              items[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: AppColor.accentTextColor,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

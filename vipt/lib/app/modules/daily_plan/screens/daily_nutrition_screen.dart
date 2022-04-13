import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/modules/daily_plan/screens/add_food_screen.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';
import 'package:vipt/app/routes/pages.dart';

class DailyNutritionScreen extends StatelessWidget {
  const DailyNutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Dinh dưỡng',
      'Luyện tập',
      'Nước',
      'Bước chân',
      'Fasting',
    ];

    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: AppColor.nutriBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            _showTabSelection(context,
                items: tabs, value: 0, onSelectedItemChanged: (value) {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 8,
              ),
              Text(
                tabs[0].tr,
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
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now().add(const Duration(days: 1)));
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
          SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                kBottomNavigationBarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.nutritionHistory);
                  },
                  child: _buildInfo(context),
                ),
                _buildNutritionFacts(),
                _buildActionButton(),
                _buildActionDescription(context),
              ],
            ),
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
        Hero(
          tag: 'caloriesIntakeWidget',
          child: SizedBox(
            width: screenWidth * 0.3,
            child: const VerticalInfoWidget(
              title: '2074',
              subtitle: 'hấp thụ',
            ),
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

  _buildNutritionFacts() {
    return Hero(
      tag: 'nutritionFactWidget',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          FittedBox(
            child: SizedBox(
              height: 80,
              child: InfoCubeWidget(
                width: 90,
                height: 90,
                title: '100g',
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
                title: '100g',
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
                title: '100g',
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
    );
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
              child: const ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: AddFoodScreen()),
            ),
            isScrollControlled: true,
          );
        },
        child: SvgPicture.asset(
          SVGAssetString.nutritionHeart,
        ),
      ),
    );
  }

  _buildActionDescription(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 24),
      child: Text(
        'Chạm vào trái tim xanh để cập nhật lượng thức ăn đã ăn.',
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
    showDialog(
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

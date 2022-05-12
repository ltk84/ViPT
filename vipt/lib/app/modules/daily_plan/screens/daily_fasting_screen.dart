import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/modules/daily_plan/widgets/floating_property_tile.dart';
import 'package:vipt/app/modules/daily_plan/widgets/icon_info_widget.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';
import 'package:vipt/app/routes/pages.dart';

import '../daily_fasting_controller.dart';

class DailyFastingScreen extends StatefulWidget {
  const DailyFastingScreen({Key? key}) : super(key: key);

  @override
  State<DailyFastingScreen> createState() => _DailyFastingScreenState();
}

class _DailyFastingScreenState extends State<DailyFastingScreen>
    with WidgetsBindingObserver {
  final _controller = Get.put(DailyFastingController());

  final _timerController = MyCountDownController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _controller.saveDataToPrefs(_timerController.getTimeInDuration());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print(state);
    switch (state) {
      case AppLifecycleState.inactive:
        await _controller.saveDataToPrefs(_timerController.getTimeInDuration());
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      default:
    }
  }

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
      backgroundColor: AppColor.fastingBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            int? newIndex;
            await _showTabSelection(context, items: tabs, value: 4,
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
                tabs[4].tr,
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
                kBottomNavigationBarHeight -
                200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfo(context),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.bodyStatus);
                  },
                  borderRadius: BorderRadius.circular(5),
                  child: _buildBodyTypeWidget(),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => FloatingPropertyTile(
              title: 'Kiểu fasting',
              value:
                  '${_controller.getTypeOfFasting(_controller.fastTypeIndex.value)['fastTime']} giờ không ăn',
              iconData: Icons.category_outlined,
              onPressed: _controller.timerIsRunning()
                  ? null
                  : () {
                      _showSelection(
                        context,
                        maxHeight: MediaQuery.of(context).size.height,
                        itemBuilder: (context, index) {
                          if (index >= 0 && index < 12) {
                            Map<String, int> fastType =
                                _controller.getTypeOfFasting(index);

                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${fastType['fastTime']} giờ không ăn - ${fastType['eatTime']} giờ ăn',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            );
                          }
                        },
                        initialValue: _controller.fastTypeIndex.value,
                        onSelectedItemChanged: (value) {
                          _controller.fastTypeIndex.value = value;
                        },
                      );
                    },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Obx(
            () => FloatingActionButton.extended(
              heroTag: 'mainActionButton',
              backgroundColor: _controller.timerIsRunning()
                  ? AppColor.accentTextColor
                  : AppColor.fastingLightBackgroundColor,
              onPressed: () {
                if (_controller.timerState.value == TimerState.ready) {
                  _timerController.start();
                  _controller.timerState.value = TimerState.running;
                  _controller.setTimeLineStrings();
                } else if (_controller.timerState.value == TimerState.running) {
                  _timerController.reset();
                  _controller.timerState.value = TimerState.ready;
                  _controller.resetTimeLineStrings();
                }
              },
              isExtended: true,
              elevation: 1,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  _controller.timerIsRunning()
                      ? 'Kết thúc Fasting'.tr
                      : 'Bắt đầu Fasting'.tr,
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: !_controller.timerIsRunning()
                            ? AppColor.accentTextColor
                            : AppColor.fastingLightBackgroundColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _buildInfo(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.3,
              child: Obx(
                () => VerticalInfoWidget(
                  title: _controller.fastingStartTimeStr.value,
                  subtitle: 'Bắt đầu Fasting',
                  reverse: true,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: screenWidth * 0.3,
              child: Obx(
                () => VerticalInfoWidget(
                  title: _controller.eatingStartTimeStr.value,
                  reverse: true,
                  subtitle: 'Bắt đầu Eating',
                ),
              ),
            ),
          ],
        ),
        FutureBuilder(
          future: _controller.loadTimerInitialValue(),
          builder: (_, snapshot) => MyCircularCountDownTimer(
              controller: _timerController,
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              isReverse: true,
              duration: _controller.timerDuration,
              initialDuration: _controller.initialDuration,
              fillColor: AppColor.accentTextColor,
              autoStart: false,
              textFormat: MyCountdownTextFormat.HH_MM_SS,
              ringColor:
                  AppColor.accentTextColor.withOpacity(AppColor.subTextOpacity),
              strokeWidth: 6,
              indicatorWidth: 8,
              onComplete: () {
                _controller.resetData();
                _controller.timerState.value = TimerState.ready;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // TODO: them icon, animation;
                    Map<String, int> currentTypeOfFasting = _controller
                        .getTypeOfFasting(_controller.fastTypeIndex.value);
                    return CustomConfirmationDialog(
                      label: 'Hoàn thành quá trình Fasting',
                      content:
                          'Bạn đã hoành thành ${currentTypeOfFasting['fastTime']} giờ Fasting và ${currentTypeOfFasting['eatTime']} giờ Eating',
                      labelCancel: 'Đóng',
                      textAlign: TextAlign.left,
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      showOkButton: false,
                      buttonsAlignment: MainAxisAlignment.end,
                    );
                  },
                );
              },
              textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColor.accentTextColor,
                    fontWeight: FontWeight.bold,
                  ),
              indicatorColor: AppColor.accentTextColor),
        ),
        Column(
          children: [
            SizedBox(
              width: screenWidth * 0.3,
              child: Obx(
                () => VerticalInfoWidget(
                  title: _controller.fastingEndTimeStr.value,
                  subtitle: 'Kết thúc Fasting',
                  reverse: true,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: screenWidth * 0.3,
              child: Obx(
                () => VerticalInfoWidget(
                  title: _controller.eatingEndTimeStr.value,
                  subtitle: 'Kết thúc Eating',
                  reverse: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildBodyTypeWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: IconInfoWidget(
        icon: SvgPicture.asset(
          SVGAssetString.bodyStatus,
          width: 28,
          height: 28,
        ),
        title: 'Trạng thái cơ thể',
      ),
    );
  }

  _showSelection(context,
      {required double maxHeight,
      required Widget? Function(BuildContext, int) itemBuilder,
      required Function(int)? onSelectedItemChanged,
      required int initialValue}) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: maxHeight * 0.32,
          child: CupertinoPicker.builder(
            onSelectedItemChanged: onSelectedItemChanged,
            backgroundColor: Colors.white,
            itemExtent: 48,
            scrollController:
                FixedExtentScrollController(initialItem: initialValue),
            itemBuilder: itemBuilder,
          ),
        );
      },
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

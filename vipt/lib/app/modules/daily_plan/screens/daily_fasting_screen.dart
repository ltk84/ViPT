import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/daily_plan/widgets/floating_property_tile.dart';
import 'package:vipt/app/modules/daily_plan/widgets/icon_info_widget.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';
import 'package:vipt/app/routes/pages.dart';

import '../daily_fasting_controller.dart';

class DailyFastingScreen extends StatefulWidget {
  DailyFastingScreen({Key? key}) : super(key: key);

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
          FloatingPropertyTile(
            title: 'Thời gian bắt đầu',
            value: '8:48',
            iconData: Icons.timer,
            onPressed: () {
              _showSelection(
                context,
                maxHeight: MediaQuery.of(context).size.height,
                itemBuilder: (context, index) {
                  if (index > 0) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        index.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    );
                  }
                },
                initialValue: 0,
                onSelectedItemChanged: (value) {},
              );
            },
          ),
          const SizedBox(
            height: 14,
          ),
          FloatingPropertyTile(
            title: 'Kiểu fasting',
            value: '12 giờ không ăn',
            iconData: Icons.category_outlined,
            onPressed: () {
              _showSelection(
                context,
                maxHeight: MediaQuery.of(context).size.height,
                itemBuilder: (context, index) {
                  if (index >= 0 && index < 12) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${12 + index} giờ không ăn - ${12 - index} giờ ăn',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    );
                  }
                },
                initialValue: 0,
                onSelectedItemChanged: (value) {},
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          FloatingActionButton.extended(
            heroTag: 'mainActionButton',
            backgroundColor: AppColor.fastingLightBackgroundColor,
            onPressed: () {},
            isExtended: true,
            elevation: 1,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            label: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Bắt đầu Fasting'.tr,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: AppColor.accentTextColor),
                textAlign: TextAlign.center,
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
        SizedBox(
          width: screenWidth * 0.3,
          child: const VerticalInfoWidget(
            title: '8:48',
            subtitle: 'Bắt đầu',
          ),
        ),
        FutureBuilder(
            future: _controller.loadTimerInitialValue(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MyCircularCountDownTimer(
                    controller: _timerController,
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    duration: _controller.timerDuration,
                    initialDuration: _controller.initialDuration,
                    fillColor: AppColor.accentTextColor,
                    autoStart: true,
                    ringColor: AppColor.accentTextColor
                        .withOpacity(AppColor.subTextOpacity),
                    strokeWidth: 6,
                    indicatorWidth: 8,
                    onComplete: () => _controller.resetData(),
                    textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppColor.accentTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                    indicatorColor: AppColor.accentTextColor);
              } else {
                return Container();
              }
            }),
        SizedBox(
          width: screenWidth * 0.3,
          child: const VerticalInfoWidget(
            title: '20:48',
            subtitle: 'Kết thúc',
          ),
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

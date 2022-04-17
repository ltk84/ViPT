import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/modules/daily_plan/daily_water_controller.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/history_tile.dart';
import 'package:vipt/app/modules/daily_plan/widgets/input_amount_dialog.dart';

class WaterHistoryScreen extends StatelessWidget {
  WaterHistoryScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DailyWaterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.waterBackgroundColor,
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
          'Lịch sử uống nước',
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
              _buildInfo(context, _controller.waterVolume),
              _buildHistoryList(context, _controller.tracks),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _buildActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildInfo(context, int volume) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Hero(
        tag: 'waterIntakeWidget',
        child: GoalProgressIndicator(
          radius: screenWidth * 0.36,
          title: volume.toString(),
          subtitle: 'ml',
          progressValue: 0.5,
        ),
      ),
    );
  }

  _buildHistoryList(context, List<WaterTracker> waterHistory) {
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
          ...waterHistory.map((log) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: HistoryTile(
                title: 'Nước',
                description: log.waterVolume.toString() + 'ml',
                date: '${log.date.day}/${log.date.month}/${log.date.year}',
                time: '${log.date.hour}:${log.date.minute}',
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  _buildActionButton(context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: ScaleTap(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return InputAmountDialog(
                title: 'Nước',
                unit: 'ml',
                value: 200,
                confirmButtonColor: AppColor.waterBackgroundColor,
                confirmButtonText: 'Thêm',
                sliderActiveColor: AppColor.waterDarkBackgroundColor,
                sliderInactiveColor: AppColor.waterBackgroundColor.withOpacity(
                  AppColor.subTextOpacity,
                ),
              );
            },
          );
        },
        child: SvgPicture.asset(
          SVGAssetString.dropWater,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}

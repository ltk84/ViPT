import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/history_tile.dart';

class WaterHistoryScreen extends StatelessWidget {
  const WaterHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> waterHistory = [
      {
        'name': 'Nước',
        'description': '200ml',
        'date': '11/04/2022',
        'time': '10:00',
      },
      {
        'name': 'Nước',
        'description': '250ml',
        'date': '12/04/2022',
        'time': '12:30',
      },
      {
        'name': 'Nước',
        'description': '300ml',
        'date': '05/05/2022',
        'time': '16:30',
      },
      {
        'name': 'Nước',
        'description': '500ml',
        'date': '03/04/2022',
        'time': '18:30',
      }
    ];

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
              _buildInfo(context),
              _buildHistoryList(context, waterHistory),
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

  _buildInfo(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Hero(
        tag: 'waterIntakeWidget',
        child: GoalProgressIndicator(
          radius: screenWidth * 0.36,
          title: '2000',
          subtitle: 'ml',
          progressValue: 0.5,
        ),
      ),
    );
  }

  _buildHistoryList(context, List<Map<String, String>> waterHistory) {
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
                title: log['name'] ?? '',
                description: log['description'] ?? '',
                date: log['date'] ?? '',
                time: log['time'] ?? '',
              ),
            );
          }).toList(),
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
        onPressed: () {},
        child: SvgPicture.asset(
          SVGAssetString.dropWater,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}

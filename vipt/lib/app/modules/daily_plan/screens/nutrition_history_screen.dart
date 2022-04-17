import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/modules/daily_plan/widgets/history_tile.dart';
import 'package:vipt/app/modules/daily_plan/widgets/vertical_info_widget.dart';

class NutritionHistoryScreen extends StatelessWidget {
  const NutritionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> nutritionHistory = [
      {
        'name': 'Thịt bò',
        'description': '260 kcal',
        'date': '11/04/2022',
        'time': '10:00',
      },
      {
        'name': 'Thịt heo',
        'description': '300 kcal',
        'date': '12/04/2022',
        'time': '12:30',
      },
      {
        'name': 'Táo',
        'description': '35 kcal',
        'date': '05/05/2022',
        'time': '16:30',
      },
      {
        'name': 'Chuối',
        'description': '38 kcal',
        'date': '03/04/2022',
        'time': '18:30',
      }
    ];

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
              _buildInfo(context),
              _buildNutritionFacts(),
              _buildHistoryList(context, nutritionHistory),
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
              child: const VerticalInfoWidget(
                title: '2074',
                subtitle: 'calories hấp thụ',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildNutritionFacts() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Hero(
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
      ),
    );
  }

  _buildHistoryList(context, List<Map<String, String>> nutritionHistory) {
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
          SVGAssetString.nutritionHeart,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class MealPlanDishesWidget extends StatelessWidget {
  final List<MealNutrition> dishes;
  final int day;

  const MealPlanDishesWidget(
      {Key? key, required this.dishes, required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ngày $day',
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
          },
          children: _getListTableRow(context),
        ),
      ],
    );
  }

  List<TableRow> _getListTableRow(context) {
    List<TableRow> rows = [];
    for (int i = 0; i < dishes.length; i++) {
      rows.add(
        _buildDishesRow(
          context,
          dish: dishes[i],
        ),
      );
      rows.add(
        _buildEmptyRow(),
      );
    }
    return rows;
  }

  TableRow _buildDishesRow(context, {required MealNutrition dish}) {
    return TableRow(children: [
      TableCell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomTile(
            type: 3,
            asset: dish.meal.asset,
            onPressed: () {
              Get.toNamed(Routes.dishDetail, arguments: dish);
            },
            title: dish.meal.name,
            description: '1000 kcal',
          ),
        ),
      ),
    ]);
  }

  TableRow _buildEmptyRow() {
    return const TableRow(children: [
      SizedBox(
        height: 12,
      ),
    ]);
  }
}

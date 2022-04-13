import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/daily_plan/widgets/input_amount_dialog.dart';

class DishIngredientsWidget extends StatelessWidget {
  final bool showTitle;
  final Map<String, String> ingredients;
  final Color? tileColor;
  final bool enableEdittingAmount;

  const DishIngredientsWidget({
    Key? key,
    this.showTitle = true,
    required this.ingredients,
    this.tileColor,
    this.enableEdittingAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Text(
            'Nguyên liệu',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
        if (showTitle)
          const SizedBox(
            height: 12,
          ),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FixedColumnWidth(12),
            2: IntrinsicColumnWidth(),
          },
          children: _getListTableRow(context),
        ),
      ],
    );
  }

  List<TableRow> _getListTableRow(context) {
    List<TableRow> rows = [];
    for (int i = 0; i < ingredients.length; i++) {
      rows.add(
        _buildIngredientRow(context,
            title: ingredients.keys.elementAt(i).toString(),
            amount: ingredients.values.elementAt(i).toString(),
            onAmountPressed: enableEdittingAmount
                ? () async {
                    final result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InputAmountDialog(
                          title:
                              'Khối lượng ${ingredients.keys.elementAt(i).toLowerCase()}',
                          unit: ingredients.values
                              .elementAt(i)
                              .replaceAll(RegExp(r"[0-9]"), ""),
                          value: int.tryParse(ingredients.values
                                  .elementAt(i)
                                  .replaceAll(RegExp(r"\D"), "")) ??
                              0,
                          confirmButtonColor: AppColor.nutriBackgroundColor,
                          confirmButtonText: 'Xác nhận',
                          sliderActiveColor: AppColor.nutriDarkBackgroundColor,
                          sliderInactiveColor:
                              AppColor.nutriBackgroundColor.withOpacity(
                            AppColor.subTextOpacity,
                          ),
                        );
                      },
                    );
                  }
                : null),
      );
      rows.add(
        _buildEmptyRow(),
      );
    }
    return rows;
  }

  TableRow _buildIngredientRow(
    context, {
    required String title,
    required String amount,
    void Function()? onAmountPressed,
  }) {
    return TableRow(children: [
      TableCell(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: tileColor ?? Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
      const SizedBox(
        width: 12,
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.fill,
        child: Material(
          color: tileColor ?? Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: onAmountPressed,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(18),
              child: Text(
                amount,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
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
      SizedBox(
        height: 12,
      ),
      SizedBox(
        height: 12,
      ),
    ]);
  }
}

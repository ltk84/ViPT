import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class DishIngredientsWidget extends StatelessWidget {
  final bool showTitle;
  final List<Map<String, String>> ingredients;

  const DishIngredientsWidget(
      {Key? key, this.showTitle = true, required this.ingredients})
      : super(key: key);

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
        _buildIngredientRow(
          context,
          title: ingredients[i].keys.toString(),
          amount: ingredients[i].values.toString(),
        ),
      );
      rows.add(
        _buildEmptyRow(),
      );
    }
    return rows;
  }

  TableRow _buildIngredientRow(context,
      {required String title, required String amount}) {
    return TableRow(children: [
      TableCell(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            amount,
            style: Theme.of(context).textTheme.caption,
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

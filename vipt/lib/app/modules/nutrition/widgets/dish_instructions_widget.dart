import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class DishInstructionsWidget extends StatelessWidget {
  final bool showTitle;
  final List<String> instructions;
  const DishInstructionsWidget(
      {Key? key, this.showTitle = true, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Text(
            'Hướng dẫn',
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
          },
          children: _getListTableRow(context),
        ),
      ],
    );
  }

  List<TableRow> _getListTableRow(context) {
    List<TableRow> rows = [];
    for (int i = 0; i < instructions.length; i++) {
      rows.add(
        _buildInstructionsRow(
          context,
          content: instructions[i],
        ),
      );
      rows.add(
        _buildEmptyRow(),
      );
    }
    return rows;
  }

  TableRow _buildInstructionsRow(context, {required String content}) {
    return TableRow(children: [
      TableCell(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
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
    ]);
  }
}

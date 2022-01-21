import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/modules/setup_info/widgets/choice_card.dart';

class MultipleChoiceTwoColumnsLayout extends StatelessWidget {
  final bool isMultipleSelectionMode;
  final List<Answer> listAnswers;
  const MultipleChoiceTwoColumnsLayout(
      {Key? key,
      this.isMultipleSelectionMode = true,
      required this.listAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        reverse: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          ResponsiveGridRow(
            children: listAnswers
                .map((answer) => ResponsiveGridCol(
                      xs: 6,
                      child: ChoiceCard(
                        title: answer.title,
                        isMultipleSelectionMode: isMultipleSelectionMode,
                        subtitle: answer.description,
                        asset: answer.asset,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

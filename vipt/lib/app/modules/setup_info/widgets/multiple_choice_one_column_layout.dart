import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_card.dart';

import '../setup_info_controller.dart';

class MultipleChoiceOneColumnLayout extends StatelessWidget {
  final bool isMultipleSelectionMode;
  final List<Answer> listAnswers;

  const MultipleChoiceOneColumnLayout(
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
                      xs: 12,
                      child: MultipleChoiceCard(
                        title: answer.title,
                        subtitle: answer.description,
                        asset: answer.asset,
                        isSelected: answer.isSelected,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

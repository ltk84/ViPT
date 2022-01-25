import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_card.dart';

class MultipleChoiceTwoColumnsLayout extends StatelessWidget {
  final List<Answer> listAnswers;

  const MultipleChoiceTwoColumnsLayout({Key? key, required this.listAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          ResponsiveGridRow(
            children: listAnswers
                .map((answer) => ResponsiveGridCol(
                      xs: 6,
                      child: MultipleChoiceCard(
                        title: answer.title,
                        subtitle: answer.description,
                        asset: answer.asset,
                        isSelected: answer.isSelected,
                        onSelected: () => Get.find<SetupInfoController>()
                            .handleMultipleSelectAnswer(answer.title),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';
import 'package:vipt/app/modules/setup_info/widgets/single_choice_card.dart';

class SingleChoiceTwoColumnsLayout extends StatelessWidget {
  final List<Answer> listAnswers;
  final String? groupValue;
  const SingleChoiceTwoColumnsLayout(
      {Key? key, required this.groupValue, required this.listAnswers})
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
                .map(
                  (answer) => ResponsiveGridCol(
                    xs: 6,
                    child: SingleChoiceCard(
                      title: answer.title,
                      value: answer.title,
                      groupValue: groupValue,
                      subtitle: answer.description,
                      asset: answer.asset,
                      onSelected: () => Get.find<SetupInfoController>()
                          .handleSingleSelectAnswer(answer.title),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

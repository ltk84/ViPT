import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/modules/setup_info/widgets/single_choice_card.dart';

class SingleChoiceOneColumnLayout extends StatelessWidget {
  final List<Answer> listAnswers;
  final String? groupValue;
  const SingleChoiceOneColumnLayout(
      {Key? key, required this.groupValue, required this.listAnswers})
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
                .map(
                  (answer) => ResponsiveGridCol(
                    xs: 12,
                    child: SingleChoiceCard(
                      title: answer.title,
                      value: answer.title,
                      groupValue: groupValue,
                      subtitle: answer.description,
                      asset: answer.asset,
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

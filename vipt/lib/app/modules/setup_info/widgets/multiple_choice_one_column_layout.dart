import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_card.dart';

class MultipleChoiceOneColumnLayout extends StatelessWidget {
  final List<Answer> listAnswers;

  const MultipleChoiceOneColumnLayout({Key? key, required this.listAnswers})
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

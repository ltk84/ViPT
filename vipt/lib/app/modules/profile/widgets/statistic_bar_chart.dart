import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/week_picker_dialog.dart';

class StatisticBarChart extends StatelessWidget {
  final List<int> values;
  final String? title;
  final String? description;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final Color? foregroundColor;
  final Color? emptyBarColor;
  const StatisticBarChart(
      {Key? key,
      required this.values,
      this.title,
      this.description,
      this.backgroundColor,
      this.titleColor,
      this.descriptionColor,
      this.foregroundColor,
      this.emptyBarColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maximum = values.reduce(max).toDouble();

    Widget getBotomTitles(double value, TitleMeta meta) {
      TextStyle? style = Theme.of(context).textTheme.headline5!.copyWith(
          color: foregroundColor ?? AppColor.statisticExerciseForegroundColor);
      Widget text;
      switch (value.toInt()) {
        case 0:
          text = Text('T2', style: style);
          break;
        case 1:
          text = Text('T3', style: style);
          break;
        case 2:
          text = Text('T4', style: style);
          break;
        case 3:
          text = Text('T5', style: style);
          break;
        case 4:
          text = Text('T6', style: style);
          break;
        case 5:
          text = Text('T7', style: style);
          break;
        case 6:
          text = Text('CN', style: style);
          break;
        default:
          text = Text('', style: style);
          break;
      }
      return Padding(padding: const EdgeInsets.only(top: 16), child: text);
    }

    Widget getLeftTitles(double value, TitleMeta meta) {
      TextStyle? style = Theme.of(context).textTheme.headline5!.copyWith(
          color: foregroundColor ?? AppColor.statisticExerciseForegroundColor);
      Widget text;
      if (value == maximum) {
        text = Text(value.toStringAsFixed(0), style: style);
      } else if (value.toInt() == maximum ~/ 2) {
        text = Text(value.toStringAsFixed(0), style: style);
      } else if (value == 0) {
        text = Text('0', style: style);
      } else {
        text = Text('', style: style);
      }
      return Padding(padding: const EdgeInsets.only(left: 8), child: text);
    }

    BarChartGroupData makeGroupData(
      int x,
      double y, {
      Color? barColor,
      double width = 20,
      List<int> showTooltips = const [],
    }) {
      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y,
            color: barColor ?? AppColor.accentTextLightColor,
            width: width,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maximum,
              color: emptyBarColor ?? AppColor.statisticExerciseBarColor,
            ),
          ),
        ],
        showingTooltipIndicators: showTooltips,
      );
    }

    List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, values[0].toDouble());
            case 1:
              return makeGroupData(1, values[1].toDouble());
            case 2:
              return makeGroupData(2, values[2].toDouble());
            case 3:
              return makeGroupData(3, values[3].toDouble());
            case 4:
              return makeGroupData(4, values[4].toDouble());
            case 5:
              return makeGroupData(5, values[5].toDouble());
            case 6:
              return makeGroupData(6, values[6].toDouble());
            default:
              return throw Error();
          }
        });
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: backgroundColor ?? AppColor.statisticExerciseBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: titleColor ??
                                      AppColor.statisticExerciseTitleColor),
                        ),
                      if (title != null)
                        const SizedBox(
                          height: 4,
                        ),
                      if (description != null)
                        Text(
                          description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: descriptionColor ??
                                    AppColor.statisticExerciseDescriptionColor,
                              ),
                        ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const WeekPickerDialog();
                          },
                        );
                        print(result);
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.date_range_rounded,
                          color: titleColor ??
                              AppColor.statisticExerciseTitleColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBotomTitles,
                          reservedSize: 38,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getLeftTitles,
                          reservedSize: 48,
                          interval: 1,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingGroups(),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

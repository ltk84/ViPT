import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vipt/app/core/values/colors.dart';

class StatisticLineChart extends StatelessWidget {
  final Map<String, double> values;

  final String? title;
  final String? description;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final List<Color>? gradient;

  final Color? descriptionColor;
  const StatisticLineChart(
      {Key? key,
      required this.values,
      this.foregroundColor,
      this.backgroundColor,
      this.title,
      this.titleColor,
      this.description,
      this.descriptionColor,
      this.borderColor,
      this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> intValues = values.entries.map((e) => e.value).toList();
    double maximum = (intValues.reduce(max) + 1).toDouble();
    double minimum = (intValues.reduce(min) - 1).toDouble();
    List<Color> gradientColors =
        gradient ?? AppColor.weightTrackingGradientColors;

    Widget getBotomTitles(double value, TitleMeta meta) {
      TextStyle? style = Theme.of(context).textTheme.headline5!.copyWith(
          color: foregroundColor ?? AppColor.weightTrackingForegroundColor);
      Widget text;
      switch (value.toInt()) {
        case 0:
          text = Text('Th1', style: style);
          break;
        case 5:
          text = Text('Th6', style: style);
          break;
        case 11:
          text = Text('Th12', style: style);
          break;
        default:
          text = Text('', style: style);
          break;
      }
      return Padding(padding: const EdgeInsets.only(top: 16), child: text);
    }

    Widget getLeftTitles(double value, TitleMeta meta) {
      TextStyle? style = Theme.of(context).textTheme.headline5!.copyWith(
          color: foregroundColor ?? AppColor.weightTrackingForegroundColor);
      Widget text;
      if (value == maximum ||
          value.toInt() == maximum ~/ 2 ||
          value == minimum) {
        text = Text(value.toStringAsFixed(0), style: style);
      } else {
        text = Text('', style: style);
      }
      return Padding(padding: const EdgeInsets.only(left: 8), child: text);
    }

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: backgroundColor ?? AppColor.weightTrackingBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: titleColor ?? AppColor.weightTrackingTitleColor),
                ),
              if (title != null)
                const SizedBox(
                  height: 4,
                ),
              if (description != null)
                Text(
                  description!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: descriptionColor ??
                            AppColor.weightTrackingDescriptionColor,
                      ),
                ),
              const SizedBox(
                height: 36,
              ),
              Expanded(
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38,
                          interval: 1,
                          getTitlesWidget: getBotomTitles,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: getLeftTitles,
                          reservedSize: 38,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: borderColor ??
                                AppColor.weightTrackingBorderColor,
                            width: 1)),
                    minX: 0,
                    maxX: 11,
                    minY: minimum,
                    maxY: maximum,
                    lineBarsData: [
                      LineChartBarData(
                        spots: getFlSpot(),
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        barWidth: 5,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: false,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> getFlSpot() {
    List<FlSpot> results = [];

    values.forEach((k, v) {
      try {
        DateFormat format = DateFormat("yyyy/MM/dd");
        DateTime date = format.parse(k);
        double x = (date.month - 1).toDouble() +
            date.day.toDouble() /
                DateUtils.getDaysInMonth(date.year, date.month).toDouble();
        double y = v.toDouble();

        results.add(
          FlSpot(x, y),
        );
      } catch (e) {
        print(e);
      }
    });
    results.sort((a, b) => a.x.compareTo(b.x));
    return results;
  }
}

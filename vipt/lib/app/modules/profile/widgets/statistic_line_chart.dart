import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:vipt/app/core/values/colors.dart';

class StatisticLineChart extends StatelessWidget {
  final Map<DateTime, double> values;

  final String? title;
  final String? description;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final List<Color>? gradient;
  final Function()? onPressHandler;

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
      this.gradient,
      this.onPressHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatePeriod datePeriod =
        DatePeriod(values.entries.first.key, values.entries.last.key);
    int dateDiff = datePeriod.end.difference(datePeriod.start).inDays;

    List<double> intValues = values.entries.map((e) => e.value).toList();
    double maximum = (intValues.reduce(max) + 1).toDouble();
    double minimum = (intValues.reduce(min) - 1).toDouble();
    List<Color> gradientColors =
        gradient ?? AppColor.weightTrackingGradientColors;

    Widget getBotomTitles(double value, TitleMeta meta) {
      TextStyle? style = Theme.of(context).textTheme.headline5!.copyWith(
          fontSize: 14,
          color: foregroundColor ?? AppColor.weightTrackingForegroundColor);
      Widget text;
      String dateFormatStart =
          '${datePeriod.start.day}/${datePeriod.start.month}/${datePeriod.start.year}';
      String dateFormatEnd =
          '${datePeriod.end.day}/${datePeriod.end.month}/${datePeriod.end.year}';

      if (value.toInt() == 0) {
        text = Text(dateFormatStart, style: style);
      } else if (value.toInt() == dateDiff) {
        text = Text(dateFormatEnd, style: style);
      } else {
        text = Text('', style: style);
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
        if (value < 0) {
          text = Text(
            '',
            style: style,
          );
        }
      } else {
        text = Text('', style: style);
      }
      return Padding(padding: const EdgeInsets.only(left: 8), child: text);
    }

    List<FlSpot> getFlSpot() {
      List<FlSpot> results = [];

      values.forEach((k, v) {
        try {
          double x = k.difference(datePeriod.start).inDays.toDouble();
          double y = v.toDouble();

          if (y != -1) {
            results.add(
              FlSpot(x, y),
            );
          }
        } catch (e) {
          print(e);
        }
      });
      results.sort((a, b) => a.x.compareTo(b.x));
      return results;
    }

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: backgroundColor ?? AppColor.weightTrackingBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                                      AppColor.weightTrackingTitleColor),
                        ),
                      if (title != null)
                        const SizedBox(
                          height: 4,
                        ),
                      if (description != null)
                        Text(
                          description!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: descriptionColor ??
                                        AppColor.weightTrackingDescriptionColor,
                                  ),
                        ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: onPressHandler,
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.date_range_rounded,
                          color: titleColor ??
                              AppColor.weightTrackingDescriptionColor,
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
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 36,
                  ),
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
                      maxX: dateDiff.toDouble(),
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
                            show: true,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

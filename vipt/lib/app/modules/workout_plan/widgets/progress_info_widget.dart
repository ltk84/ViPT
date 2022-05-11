import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/workout_collection/widgets/expandable_widget.dart';

class ProgressInfoWidget extends StatefulWidget {
  final List<bool> completeDays;
  const ProgressInfoWidget({Key? key, required this.completeDays})
      : super(key: key);

  @override
  State<ProgressInfoWidget> createState() => _ProgressInfoWidgetState();
}

class _ProgressInfoWidgetState extends State<ProgressInfoWidget> {
  late bool _expand;

  @override
  void initState() {
    _expand = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _progressValue = _getProgressValue();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _expand = !_expand;
              });
            },
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tiến trình',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: AppColor.accentTextColor,
                        ),
                  ),
                  Icon(
                      _expand
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColor.accentTextColor),
                ],
              ),
            ),
          ),
        ),
        ExpandableWidget(
          expand: _expand,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ngày',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Wrap(
                  spacing: 28.0,
                  runSpacing: 16.0,
                  children: _buildDayIndicatorList(context),
                ),
                const SizedBox(
                  height: 36,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: _progressValue,
                        minHeight: 8,
                        backgroundColor: AppColor.textFieldUnderlineColor
                            .withOpacity(AppColor.subTextOpacity),
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.lerp(Alignment.topLeft,
                          Alignment.topRight, _progressValue + 0.05)!,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                            '${(_progressValue * 100).toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _getProgressValue() {
    int count = widget.completeDays.length;
    int progress = widget.completeDays.where((element) => element).length;

    return progress.toDouble() / count.toDouble();
  }

  List<Widget> _buildDayIndicatorList(context) {
    List<Widget> results = [];
    for (int i = 0; i < widget.completeDays.length; i++) {
      results.add(
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              widget.completeDays[i]
                  ? SVGAssetString.checkedDay
                  : SVGAssetString.uncheckedDay,
              height: 56,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                '${i + 1}',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
            ),
          ],
        ),
      );
    }
    return results;
  }
}

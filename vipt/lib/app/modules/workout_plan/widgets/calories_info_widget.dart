import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/workout_collection/widgets/expandable_widget.dart';

class CaloriesInfoWidget extends StatefulWidget {
  final int currentCalories;
  final int goalCalories;
  final Function()? onAutoRecommend;
  final Function()? onChangeGoal;
  final String unit;
  const CaloriesInfoWidget(
      {Key? key,
      this.currentCalories = 0,
      this.goalCalories = 0,
      this.onAutoRecommend,
      this.onChangeGoal,
      this.unit = 'kcal'})
      : super(key: key);

  @override
  State<CaloriesInfoWidget> createState() => _CaloriesInfoWidgetState();
}

class _CaloriesInfoWidgetState extends State<CaloriesInfoWidget> {
  late bool _expand;

  @override
  void initState() {
    _expand = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    'Calories mỗi ngày',
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hiện tại',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      'Mục tiêu',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: widget.goalCalories != 0 &&
                            !widget.goalCalories.isNaN &&
                            !widget.currentCalories.isNaN
                        ? widget.currentCalories / widget.goalCalories
                        : 0,
                    minHeight: 6,
                    backgroundColor: AppColor.textFieldUnderlineColor
                        .withOpacity(AppColor.subTextOpacity),
                    color: widget.currentCalories > widget.goalCalories
                        ? AppColor.primaryColor
                        : AppColor.secondaryColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.currentCalories} ${widget.unit}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '${widget.goalCalories} ${widget.unit}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.logWeightButtonColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: widget.onAutoRecommend,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Tự động đề xuất',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: AppColor.accentTextColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: widget.onChangeGoal,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Thay đổi mục tiêu',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: AppColor.logWeightButtonColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

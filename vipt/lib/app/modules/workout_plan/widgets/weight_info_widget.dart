import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/workout_collection/widgets/expandable_widget.dart';
import 'package:vipt/app/modules/workout_plan/workout_plan_controller.dart';

class WeightInfoWidget extends StatefulWidget {
  const WeightInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WeightInfoWidget> createState() => _WeightInfoWidgetState();
}

class _WeightInfoWidgetState extends State<WeightInfoWidget> {
  final _controller = Get.find<WorkoutPlanController>();

  late bool _expand;

  @override
  void initState() {
    _expand = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
                      'Cân nặng',
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
                      value: _controller.currentWeight.value.toInt() /
                          _controller.goalWeight.value.toInt(),
                      minHeight: 6,
                      backgroundColor: AppColor.textFieldUnderlineColor
                          .withOpacity(AppColor.subTextOpacity),
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_controller.currentWeight.value} ${_controller.unit}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        '${_controller.goalWeight.value} ${_controller.unit}',
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
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) {
                              TextEditingController weightEditingController =
                                  TextEditingController(
                                      text: _controller.currentWeight.value
                                          .toString());
                              return Material(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: TextField(
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    controller: weightEditingController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value) async {
                                      await _controller.logWeight(value);
                                      Get.back();
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                      filled: true,
                                      hintText: 'Điền vào đây'.tr,
                                      hintStyle:
                                          Theme.of(context).textTheme.subtitle2,
                                      fillColor: AppColor.textFieldFill,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(28),
                                            bottomRight: Radius.circular(28),
                                          )),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Cập nhật cân nặng',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
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
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Thay đổi mục tiêu',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';

class MeasurementPickerLayout extends StatefulWidget {
  const MeasurementPickerLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<MeasurementPickerLayout> createState() =>
      _MeasurementPickerLayoutState();
}

class _MeasurementPickerLayoutState extends State<MeasurementPickerLayout> {
  final _controller = Get.find<SetupInfoController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: _buildMeasurementField(
        context,
        primaryUnit: 'kg',
        initalValue: _controller.toggleValueForMeasureLayout,
        secondaryUnit: 'lbs',
        textFieldController: _controller.textFieldControllerForMeasureLayout,
        onUnitChanged: (value) {
          setState(() {
            _controller.toggleValueForMeasureLayout = value;
          });
        },
      ),
    );
  }
}

// Hàm build các field nhập chỉ số đo lường như cân nặng, chiều cao.
Widget _buildMeasurementField(context,
    {required String primaryUnit,
    required String secondaryUnit,
    required int? initalValue,
    required TextEditingController textFieldController,
    required Function(int?) onUnitChanged}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CupertinoSlidingSegmentedControl(
        groupValue: initalValue,
        onValueChanged: onUnitChanged,
        children: {
          0: Container(
            color: Colors.transparent,
            width: double.maxFinite,
            child: Text(primaryUnit, textAlign: TextAlign.center),
          ),
          1: Container(
            color: Colors.transparent,
            width: double.maxFinite,
            child: Text(secondaryUnit, textAlign: TextAlign.center),
          ),
        },
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.center,
        child: TextField(
          style: Theme.of(context).textTheme.bodyText2,
          controller: textFieldController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: true,
            hintText: 'Điền vào đây'.tr,
            hintStyle: Theme.of(context).textTheme.subtitle2,
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
    ],
  );
}

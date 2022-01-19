import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/modules/error/screens/error_screen.dart';

class PickerLayout extends StatelessWidget {
  final int type;
  const PickerLayout({Key? key, this.type = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _handleFieldSelection(context, type),
    );
  }
}

// Hàm xử lý chọn dang field (field nhập chỉ số đo lường hay field chọn ngày tháng năm).
Widget _handleFieldSelection(context, type) {
  switch (type) {
    // Case 0 là build field nhập chỉ số đo lường.
    case 0:
      return _buildMeasurementField(
        context,
        primaryUnit: 'kg',
        secondaryUnit: 'lbs',
        onTextFieldChanged: (value) {},
        onUnitChanged: (value) {},
      );

    // Case 1 là build field chọn ngày tháng năm.
    case 1:
      return _buildDatePickerField(context);
  }
  return ErrorScreen();
}

// Hàm build các field nhập chỉ số đo lường như cân nặng, chiều cao.
Widget _buildMeasurementField(context,
    {required String primaryUnit,
    required String secondaryUnit,
    required Function(String?) onTextFieldChanged,
    required Function(int?) onUnitChanged}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CupertinoSlidingSegmentedControl(
        groupValue: 0,
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
          onChanged: onTextFieldChanged,
          style: Theme.of(context).textTheme.bodyText2,
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

// Hàm build các field chọn ngày tháng năm như ngày sinh.
Widget _buildDatePickerField(context) {
  return TextField(
    onTap: () {},
    onChanged: (value) {},
    focusNode: AlwaysDisabledFocusNode(),
    style: Theme.of(context).textTheme.bodyText2,
    textAlign: TextAlign.center,
    decoration: AppDecoration.dateTimeFieldDecoration,
  );
}

// Dùng cho việc ngăn con trỏ nhảy vào text field khi người dùng ấn vào.
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

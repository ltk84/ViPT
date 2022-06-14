import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';

class DatePickerLayout extends StatelessWidget {
  final TextEditingController textFieldController;
  final Function handleChangeDateTime;
  String? errorText;
  DateTime? initialDate;

  DatePickerLayout(
      {required this.textFieldController,
      required this.handleChangeDateTime,
      this.errorText,
      this.initialDate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: _buildDatePickerField(context, textFieldController,
          handleChangeDateTime, errorText, initialDate ?? DateTime(2001)),
    );
  }
}

// Hàm build các field chọn ngày tháng năm như ngày sinh.
Widget _buildDatePickerField(context, TextEditingController controller,
    Function handleChangeDateTime, String? errorText, DateTime initialDate) {
  return TextField(
    onTap: () async {
      var dateTime = await showDatePicker(
          locale: const Locale("vi", "VI"),
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1970),
          lastDate: DateTime.now());
      if (dateTime != null) {
        handleChangeDateTime(dateTime);
      }
    },
    controller: controller,
    focusNode: AlwaysDisabledFocusNode(),
    style: Theme.of(context).textTheme.bodyText2,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      errorText: errorText,
      filled: true,
      suffixIcon: const Icon(
        Icons.calendar_today_rounded,
        size: 18,
      ),
      hintText: 'Chạm vào để chọn'.tr,
      hintStyle: Theme.of(context).textTheme.subtitle2,
      fillColor: AppColor.textFieldFill,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(10),
        ),
      ),
    ),
  );
}

// Dùng cho việc ngăn con trỏ nhảy vào text field khi người dùng ấn vào.
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

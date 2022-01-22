import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';

class DatePickerLayout extends StatelessWidget {
  final TextEditingController textFieldController;
  final Function handleChangeDateTime;
  const DatePickerLayout(
      {required this.textFieldController,
      required this.handleChangeDateTime,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: _buildDatePickerField(
          context, textFieldController, handleChangeDateTime),
    );
  }
}

// Hàm build các field chọn ngày tháng năm như ngày sinh.
Widget _buildDatePickerField(
    context, TextEditingController controller, Function handleChangeDateTime) {
  return TextField(
    onTap: () async {
      var dateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      handleChangeDateTime(dateTime);
    },
    controller: controller,
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

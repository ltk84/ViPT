import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vipt/app/core/values/values.dart';

class DatePickerLayout extends StatelessWidget {
  const DatePickerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _buildDatePickerField(
        context,
      ),
    );
  }
}

// Hàm build các field chọn ngày tháng năm như ngày sinh.
Widget _buildDatePickerField(context) {
  return TextField(
    onTap: () {
      _showDatePicker(context);
    },
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

void _showDatePicker(ctx) {
  showCupertinoModalPopup(
    context: ctx,
    builder: (_) => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (val) {}),
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(ctx).pop(),
        )
      ],
    ),
  );
}

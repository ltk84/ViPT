import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';

class PickerLayout extends StatelessWidget {
  const PickerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        onTap: () {},
        focusNode: AlwaysDisabledFocusNode(),
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center,
        decoration: AppDecoration.dateTimeFieldDecoration,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

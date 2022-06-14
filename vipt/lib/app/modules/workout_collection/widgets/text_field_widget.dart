import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final TextStyle? textStyle;
  final bool underline;
  final TextEditingController textEditingController;
  const TextFieldWidget(
      {Key? key,
      this.hint,
      this.errorText,
      this.textStyle,
      this.underline = true,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        controller: textEditingController,
        style: textStyle,
        textAlign: TextAlign.center,
        decoration: underline
            ? InputDecoration(
                hintText: hint,
                errorText: errorText,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.textFieldUnderlineColor
                        .withOpacity(AppColor.subTextOpacity),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.textFieldUnderlineColor
                        .withOpacity(AppColor.subTextOpacity),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColor.textFieldUnderlineColor
                          .withOpacity(AppColor.subTextOpacity)),
                ),
              )
            : InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                errorText: errorText,
              ),
      ),
    );
  }
}

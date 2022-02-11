import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';

class SearchFieldWidget extends StatelessWidget {
  final TextStyle? textStyle;
  const SearchFieldWidget({
    Key? key,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        style: textStyle,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search),
          fillColor: AppColor.textFieldFill.withOpacity(
            AppColor.subTextOpacity,
          ),
          hintText: 'Tìm kiếm'.tr,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
        ),
      ),
    );
  }
}

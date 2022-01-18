import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class TextFieldLayout extends StatelessWidget {
  const TextFieldLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.progressIndicatorColor.withOpacity(0.5),
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(28),
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              )),
        ),
      ),
    );
  }
}

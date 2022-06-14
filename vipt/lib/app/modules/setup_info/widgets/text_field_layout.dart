import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';

class TextFieldLayout extends StatelessWidget {
  final TextEditingController textEditingController;

  const TextFieldLayout({required this.textEditingController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: TextField(
        controller: textEditingController,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
        autofocus: true,
        decoration: AppDecoration.noHighlightInputDecoration,
      ),
    );
  }
}

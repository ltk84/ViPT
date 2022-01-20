import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';

class TextFieldLayout extends StatelessWidget {
  const TextFieldLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
        autofocus: true,
        decoration: AppDecoration.noHighlightInputDecoration,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vipt/app/modules/workout_collection/widgets/text_field_widget.dart';

class EditableIntroCollectionWidget extends StatelessWidget {
  final String hintTitle;
  final TextStyle? titleTextStyle;
  final TextEditingController titleTextController;
  final TextEditingController? descriptionTextController;
  const EditableIntroCollectionWidget({
    Key? key,
    required this.titleTextController,
    this.descriptionTextController,
    this.hintTitle = 'Nhập tên bộ luyện tập',
    this.titleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: TextFieldWidget(
            textEditingController: titleTextController,
            hint: hintTitle,
            textStyle: titleTextStyle ?? Theme.of(context).textTheme.headline2,
            underline: descriptionTextController != null ? true : false,
          ),
        ),
        if (descriptionTextController != null)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFieldWidget(
              textEditingController: descriptionTextController!,
              hint: 'Nhập mô tả',
              textStyle: Theme.of(context).textTheme.subtitle2,
              underline: false,
            ),
          ),
      ],
    );
  }
}

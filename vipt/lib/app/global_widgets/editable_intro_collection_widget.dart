import 'package:flutter/material.dart';
import 'package:vipt/app/modules/workout_collection/widgets/text_field_widget.dart';

class EditableIntroCollectionWidget extends StatelessWidget {
  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;
  const EditableIntroCollectionWidget(
      {Key? key,
      required this.titleTextController,
      required this.descriptionTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: TextFieldWidget(
            textEditingController: titleTextController,
            hint: 'Nhập tên bộ luyện tập',
            textStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFieldWidget(
            textEditingController: descriptionTextController,
            hint: 'Nhập mô tả',
            textStyle: Theme.of(context).textTheme.subtitle2,
            underline: false,
          ),
        ),
      ],
    );
  }
}

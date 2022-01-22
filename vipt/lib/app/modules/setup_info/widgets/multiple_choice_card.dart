import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';

class MultipleChoiceCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? asset;
  final bool isSelected;

  const MultipleChoiceCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.asset,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: isSelected
            ? BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.2,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: () {
          Get.find<SetupInfoController>().handleMultipleSelectAnswer(title);
        },
        child: ListTile(
          leading: asset == null
              ? null
              : Image.asset(
                  asset as String,
                ),
          title: Text(title, style: Theme.of(context).textTheme.headline4),
          subtitle: subtitle == null
              ? null
              : Text(subtitle as String,
                  style: Theme.of(context).textTheme.subtitle1),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                )
              : const Icon(
                  Icons.radio_button_unchecked_outlined,
                ),
        ),
      ),
    );
  }
}

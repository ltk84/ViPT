import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';

class SingleChoiceCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? asset;
  final String value;
  final String? groupValue;
  const SingleChoiceCard({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    this.subtitle,
    this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: value == groupValue
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
          Get.find<SetupInfoController>().handleSingleSelectAnswer(value);
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
        ),
      ),
    );
  }
}

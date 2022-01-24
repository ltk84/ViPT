import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';
import 'package:path/path.dart' as p;

class MultipleChoiceCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? asset;
  final bool isSelected;
  final Function onSelected;

  const MultipleChoiceCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.asset,
    required this.isSelected,
    required this.onSelected,
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
          onSelected();
        },
        child: ListTile(
          minLeadingWidth: 80,
          leading: asset == null
              ? null
              : p.extension(asset as String) == '.svg'
                  ? SvgPicture.asset(asset as String)
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

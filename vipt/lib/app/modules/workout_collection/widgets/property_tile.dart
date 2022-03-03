import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class PropertyTile extends StatelessWidget {
  final bool enabled;
  final Function() onTap;
  String title;
  String trailing;
  IconData iconData;
  PropertyTile({
    Key? key,
    this.enabled = true,
    required this.onTap,
    required this.title,
    required this.trailing,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color disabledColor =
        AppColor.textColor.withOpacity(AppColor.disabledTextOpacity);

    return ListTile(
      onTap: enabled ? onTap : null,
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: Icon(
        iconData,
        color: enabled ? AppColor.textColor : disabledColor,
      ),
      title: Text(
        title,
        style: enabled
            ? Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w500)
            : Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w500, color: disabledColor),
      ),
      trailing: Text(
        trailing,
        style: enabled
            ? Theme.of(context).textTheme.bodyText1
            : Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: disabledColor),
      ),
    );
  }
}

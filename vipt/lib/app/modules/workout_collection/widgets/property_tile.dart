import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class PropertyTile extends StatelessWidget {
  final bool enabled;
  final Function() onTap;
  final String title;
  final String trailing;
  final IconData iconData;
  final Color? foregroundColor;
  final Color? backgroundColor;
  const PropertyTile({
    Key? key,
    this.enabled = true,
    required this.onTap,
    required this.title,
    required this.trailing,
    required this.iconData,
    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color disabledColor =
        AppColor.textColor.withOpacity(AppColor.disabledTextOpacity);

    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ListTile(
        onTap: enabled ? onTap : null,
        tileColor: backgroundColor ?? AppColor.listTileButtonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        leading: Icon(
          iconData,
          color:
              !enabled ? disabledColor : foregroundColor ?? AppColor.textColor,
        ),
        title: Text(
          title,
          style: enabled
              ? Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w500, color: foregroundColor)
              : Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w500, color: disabledColor),
        ),
        trailing: Text(
          trailing,
          style: enabled
              ? Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: foregroundColor)
              : Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: disabledColor),
        ),
      ),
    );
  }
}

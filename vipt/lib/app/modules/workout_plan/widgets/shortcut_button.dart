import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class ShortcutButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Widget? icon;
  const ShortcutButton(
      {Key? key, this.onPressed, this.title = 'Phím tắt', this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
          child: Column(
            children: [
              icon ?? Icon(Icons.shortcut, color: AppColor.accentTextColor),
              const SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: AppColor.accentTextColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

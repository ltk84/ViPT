import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class FloatingActionTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;
  final Function() onPressed;

  const FloatingActionTile(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      isExtended: true,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      label: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Row(
          children: [
            Icon(iconData, color: AppColor.fastingBackgroundColor),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.fastingBackgroundColor),
              ),
            ),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColor.fastingBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

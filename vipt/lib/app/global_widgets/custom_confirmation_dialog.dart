import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String label;
  final String content;
  final TextAlign textAlign;
  final String labelCancel;
  final String labelOk;
  final Color primaryButtonColor;
  final Function()? onCancel;
  final Function()? onOk;
  final double buttonFactorOnMaxWidth;
  final MainAxisAlignment buttonsAlignment;
  final bool showCancelButton;
  final bool showOkButton;

  const CustomConfirmationDialog({
    Key? key,
    this.label = 'Title',
    this.content = 'Content',
    this.textAlign = TextAlign.center,
    this.labelCancel = 'Cancel',
    this.labelOk = 'OK',
    this.primaryButtonColor = AppColor.resumeActionConfirmationAlertColor,
    this.onCancel,
    this.onOk,
    this.buttonFactorOnMaxWidth = 0,
    this.buttonsAlignment = MainAxisAlignment.spaceBetween,
    this.showCancelButton = true,
    this.showOkButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text(
          label,
          textAlign: textAlign,
        ),
        titleTextStyle: Theme.of(context).textTheme.headline3,
        titlePadding: const EdgeInsets.fromLTRB(24, 28, 24, 4),
        content: Text(
          content,
          textAlign: textAlign,
        ),
        contentTextStyle:
            Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16),
        contentPadding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
        actions: [
          if (showCancelButton)
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth * buttonFactorOnMaxWidth,
              ),
              child: TextButton(
                child: Text(
                  labelCancel,
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 16,
                        color: AppColor.textColor
                            .withOpacity(AppColor.subTextOpacity),
                      ),
                ),
                onPressed: onCancel,
              ),
            ),
          if (showOkButton)
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth * buttonFactorOnMaxWidth,
              ),
              child: ElevatedButton(
                child: Text(
                  labelOk,
                  style: Theme.of(context).textTheme.button,
                ),
                style: ElevatedButton.styleFrom(
                  primary: primaryButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: onOk,
              ),
            ),
        ],
        actionsAlignment: buttonsAlignment,
        actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
    });
  }
}

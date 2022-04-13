import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class InputAmountDialog extends StatelessWidget {
  final String title;
  final String valueString;
  final int value;
  final int min;
  final int max;
  final Function()? onConfirm;
  final Function(double)? onValueChanged;
  final Color? confirmButtonColor;
  final Color? sliderActiveColor;
  final Color? sliderInactiveColor;
  final String confirmButtonText;

  const InputAmountDialog(
      {Key? key,
      this.title = '',
      this.valueString = '0ml',
      this.value = 0,
      this.min = 0,
      this.max = 3000,
      this.onConfirm,
      this.onValueChanged,
      this.confirmButtonColor,
      this.sliderActiveColor,
      this.sliderInactiveColor,
      this.confirmButtonText = 'Xác nhận'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        decoration: BoxDecoration(
          color: AppColor.accentTextColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.close)),
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: AppColor.textColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              valueString,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:
                        AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Slider(
              value: 200,
              onChanged: onValueChanged,
              min: 1,
              max: 3000,
              activeColor: sliderActiveColor,
              inactiveColor: sliderInactiveColor,
              thumbColor: AppColor.accentTextColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: confirmButtonColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: onConfirm,
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      confirmButtonText,
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

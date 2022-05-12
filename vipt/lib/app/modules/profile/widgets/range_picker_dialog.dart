import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:vipt/app/core/values/colors.dart';

class RangePickerDialog extends StatefulWidget {
  const RangePickerDialog({Key? key}) : super(key: key);

  @override
  State<RangePickerDialog> createState() => _RangePickerDialogState();
}

class _RangePickerDialogState extends State<RangePickerDialog> {
  late DatePeriod _selectedPeriod;

  @override
  void initState() {
    _selectedPeriod = DatePeriod(
        DateTime.now().subtract(const Duration(days: 30)), DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RangePicker(
              selectedPeriod: _selectedPeriod,
              firstDate: DateTime(1, 1, 1),
              lastDate: DateTime.now(),
              onChanged: (datePeriod) {
                setState(() {
                  _selectedPeriod = datePeriod;
                });
              },
              datePickerStyles: DatePickerRangeStyles(
                firstDayOfWeekIndex: 1,
                displayedPeriodTitle: Theme.of(context).textTheme.bodyText2,
                dayHeaderTitleBuilder: (dayOfTheWeek, localizedWeekdayHeaders) {
                  switch (dayOfTheWeek) {
                    case 0:
                      return 'CN';
                    case 1:
                      return 'T2';
                    case 2:
                      return 'T3';
                    case 3:
                      return 'T4';
                    case 4:
                      return 'T5';
                    case 5:
                      return 'T6';
                    case 6:
                      return 'T7';
                    default:
                      return '';
                  }
                },
                defaultDateTextStyle: Theme.of(context).textTheme.bodyText1,
                currentDateStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColor.primaryColor),
                selectedDateStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColor.accentTextColor),
                selectedPeriodLastDecoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(10.0),
                        bottomEnd: Radius.circular(10.0))),
                selectedPeriodStartDecoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10.0),
                      bottomStart: Radius.circular(10.0)),
                ),
                selectedPeriodMiddleDecoration: const BoxDecoration(
                    color: AppColor.primaryColor, shape: BoxShape.rectangle),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    'Hủy bỏ',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: AppColor.textColor
                              .withOpacity(AppColor.subTextOpacity),
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Xác nhận',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: AppColor.primaryColor,
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(_selectedPeriod);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

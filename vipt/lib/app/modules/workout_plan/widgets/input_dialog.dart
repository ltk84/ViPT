import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';

class InputDialog extends StatelessWidget {
  final TextEditingController weightEditingController;
  final Future<void> Function(String) logWeight;
  final String title;
  const InputDialog(
      {Key? key,
      this.title = 'Nhập cân nặng hiện tại',
      required this.weightEditingController,
      required this.logWeight})
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
                      Get.back();
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
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: weightEditingController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onSubmitted: (value) async {
                  await logWeight(value);
                  Get.back();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  hintText: 'Điền vào đây'.tr,
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  fillColor: AppColor.textFieldFill,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.logWeightButtonColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () async {
                    await logWeight(weightEditingController.text);
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Xác nhận',
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/routes/pages.dart';

class SettingController extends GetxController {
  Future<void> changeBasicInforamtion() async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          label: 'Bạn thực sự muốn thay đổi thông tin ban đầu?',
          content:
              'Tiến trình hiện tại sẽ bị thiết lập lại từ đầu và sẽ không được lưu lại',
          labelCancel: 'Hủy bỏ',
          labelOk: 'Bắt đầu lại',
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () async {
            await Get.toNamed(Routes.setupInfoQuestion);
            Get.back();
          },
          buttonsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }
}

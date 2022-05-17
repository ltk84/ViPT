import 'dart:io';

import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/modules/profile/widgets/camera_button.dart';

class ProgressImageWidget extends StatelessWidget {
  ProgressImageWidget({Key? key}) : super(key: key);

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Hình ảnh quá trình',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color:
                        AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CameraButton(
                title: 'Ảnh trước',
                onPressed: () async {
                  // TODO: mở dialog để chọn pick từ camera hoặc là từ gallery
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _controller.pickBeforeImage(image.path);
                  }
                },
              ),
            ),
            Expanded(
              child: CameraButton(
                title: 'Ảnh sau',
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _controller.pickAfterImage(image.path);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Obx(
          () => BeforeAfter(
            imageWidth: double.infinity,
            beforeImage: _controller.beforeImagePath.value.isNotEmpty
                ? Image.file(File(_controller.beforeImagePath.value))
                : Image.asset(
                    JPGAssetString.bodyBefore,
                  ),
            afterImage: _controller.afterImagePath.value.isNotEmpty
                ? Image.file(File(_controller.afterImagePath.value))
                : Image.asset(
                    JPGAssetString.bodyAfter,
                  ),
          ),
        ),
      ],
    );
  }
}

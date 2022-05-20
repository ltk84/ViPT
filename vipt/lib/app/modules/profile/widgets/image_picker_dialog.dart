import 'package:flutter/material.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/modules/profile/widgets/camera_button.dart';

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CameraButton(
                iconData: Icons.photo,
                title: 'Từ thư viện',
                onPressed: () {
                  Navigator.pop(context, ImagePickerSource.gallery);
                },
              ),
              CameraButton(
                iconData: Icons.camera_alt_rounded,
                onPressed: () {
                  Navigator.pop(context, ImagePickerSource.camera);
                },
                title: 'Chụp ảnh',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/camera_button.dart';

class ProgressImageWidget extends StatelessWidget {
  final String? pathBefore;
  final String? pathAfter;
  const ProgressImageWidget({Key? key, this.pathBefore, this.pathAfter})
      : super(key: key);

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
                onPressed: () {},
              ),
            ),
            Expanded(
              child: CameraButton(
                title: 'Ảnh sau',
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        BeforeAfter(
          imageWidth: double.infinity,
          beforeImage: Image.asset(
            pathBefore ?? JPGAssetString.bodyBefore,
          ),
          afterImage: Image.asset(
            pathBefore ?? JPGAssetString.bodyAfter,
          ),
        ),
      ],
    );
  }
}

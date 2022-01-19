import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/modules/setup_info/widgets/custom_progress_indicator.dart';
import 'package:vipt/app/modules/setup_info/widgets/picker_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/text_field_layout.dart';

class SetupInfoScreen extends StatelessWidget {
  const SetupInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: null,
        body: Container(
          padding: AppDecoration.screenPadding,
          child: _buildQuestion(context),
        ),
      ),
    );
  }
}

// Hàm build phần giới thiệu cho phần thiết lập thông tin cơ bản

Widget _buildIntro(context) {
  return Column(
    children: [
      Row(
        children: [
          Image.asset(
            PNGAssetString.logo,
            height: 25,
          ),
        ],
      ),
      Expanded(
        child: Image.asset(
          GIFAssetString.setupInfoIntro,
          fit: BoxFit.fitHeight,
        ),
      ),
      Text(
        'Cập nhật các thông tin cơ bản.'.tr,
        style: Theme.of(context).textTheme.headline1,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        'Cập nhật thông tin và trả lời các câu hỏi này để tôi có thể đề xuất lộ trình luyện tập và dinh dưỡng cụ thể dành riêng cho bạn.'
            .tr,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        color: Colors.transparent,
        width: double.maxFinite,
        height: 46,
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Bắt đầu'.tr, style: Theme.of(context).textTheme.button),
        ),
      ),
      Container(
        color: Colors.transparent,
        height: 46,
        width: double.maxFinite,
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Để sau'.tr,
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: 16,
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
        ),
      ),
    ],
  );
}

//

Widget _buildQuestion(context) {
  return Column(
    children: [
      _buildTopPanel(
        context,
        moduleCount: 4,
        progress: const [1, 1, 0.5, 0],
      ),
      const SizedBox(
        height: 20,
      ),
      _buildQuestionTitle(context,
          title: 'Question A', description: 'Description A'),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: PickerLayout(),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      _buildNextQuestionButton(context),
      _buildSkipButton(context),
    ],
  );
}

Widget _buildTopPanel(context,
    {required int moduleCount, required List<double> progress}) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      IconButton(
        iconSize: 24,
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColor.textColor,
        ),
      ),
      Expanded(
        child: CustomProgressIndicator(
          moduleCount: moduleCount,
          progress: progress,
        ),
      ),
    ],
  );
}

Widget _buildQuestionTitle(context,
    {required String title, required String description}) {
  return Column(
    children: [
      Text(
        title.tr,
        style: Theme.of(context).textTheme.headline1,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        description.tr,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ],
  );
}

Widget _buildNextQuestionButton(context) {
  return Container(
    color: Colors.transparent,
    width: double.maxFinite,
    height: 46,
    child: ElevatedButton(
      onPressed: () {},
      child: Text('Tiếp theo'.tr, style: Theme.of(context).textTheme.button),
    ),
  );
}

Widget _buildSkipButton(context) {
  return Container(
    color: Colors.transparent,
    height: 46,
    width: double.maxFinite,
    child: TextButton(
      onPressed: () {},
      child: Text(
        'Bỏ qua'.tr,
        style: Theme.of(context).textTheme.button!.copyWith(
              fontSize: 16,
              color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
            ),
      ),
    ),
  );
}

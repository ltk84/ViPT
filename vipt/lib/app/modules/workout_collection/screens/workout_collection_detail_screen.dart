import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';

class WorkoutCollectionDetailScreen extends StatelessWidget {
  const WorkoutCollectionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: Container(
        padding: AppDecoration.screenPadding.copyWith(top: 8, bottom: 0),
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              _buildIntro(context),
              const SizedBox(
                height: 8,
              ),
              _buildIndicatorDisplay(context),
              const SizedBox(
                height: 16,
              ),
              _buildRoundProperty(context, constraints.maxHeight),
              const SizedBox(
                height: 12,
              ),
              _buildWarmUpProperty(context),
              const SizedBox(
                height: 12,
              ),
              _buildShuffleProperty(context),
              const SizedBox(
                height: 12,
              ),
              _buildExerciseTimeProperty(context, constraints.maxHeight),
              const SizedBox(
                height: 12,
              ),
              _buildTransitionTimeProperty(context, constraints.maxHeight),
              const SizedBox(
                height: 12,
              ),
              _buildRestTimeProperty(context, constraints.maxHeight),
              const SizedBox(
                height: 12,
              ),
              _buildRestFrequencyProperty(context, constraints.maxHeight),
              const SizedBox(
                height: 24,
              ),
              _buildExerciseList(context),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildIntro(context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Tên bộ luyện tập'.tr,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Mô tả mô tả mô tả mô tả mô tả mô tả'.tr,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicatorDisplay(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time_filled_rounded,
          color: AppColor.textColor,
          size: 28,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '10 phút'.tr,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          height: 28,
          child: VerticalDivider(
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          CupertinoIcons.flame_fill,
          color: AppColor.textColor,
          size: 28,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '100 calo'.tr,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }

  Widget _buildRoundProperty(context, maxHeight) {
    return ListTile(
      onTap: () {
        _showSelection(context, maxHeight: maxHeight,
            itemBuilder: (context, index) {
          if (index > 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                index.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
        });
      },
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: Icon(
        Icons.repeat_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Số vòng'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        '3',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildWarmUpProperty(context) {
    return SwitchListTile(
      activeColor: Theme.of(context).primaryColor,
      onChanged: (bool value) {},
      value: false,
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      secondary: Icon(
        Icons.emoji_people_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Bắt đầu với khởi động'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildShuffleProperty(context) {
    return SwitchListTile(
      activeColor: Theme.of(context).primaryColor,
      onChanged: (bool value) {},
      value: false,
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      secondary: Icon(
        Icons.shuffle_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Trộn ngẫu nhiên'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildExerciseTimeProperty(context, maxHeight) {
    return ListTile(
      onTap: () {
        _showSelection(context, maxHeight: maxHeight,
            itemBuilder: (context, index) {
          if (index > 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                '$index giây',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
        });
      },
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: Icon(
        Icons.timelapse_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Thời gian mỗi bài'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        '20 giây'.tr,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildTransitionTimeProperty(context, maxHeight) {
    return ListTile(
      onTap: () {
        _showSelection(context, maxHeight: maxHeight,
            itemBuilder: (context, index) {
          if (index > 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                '$index giây',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
        });
      },
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: Icon(
        Icons.sync_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Thời gian chuyển'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        '15 giây'.tr,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildRestTimeProperty(context, maxHeight) {
    return ListTile(
      onTap: () {
        _showSelection(context, maxHeight: maxHeight,
            itemBuilder: (context, index) {
          if (index > 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                '$index giây',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
        });
      },
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: Icon(
        Icons.hourglass_top_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Thời gian nghỉ'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        '30 giây'.tr,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

// check check!!
  Widget _buildRestFrequencyProperty(context, maxHeight) {
    return ListTile(
      onTap: () {
        _showSelection(context, maxHeight: maxHeight,
            itemBuilder: (context, index) {
          if (index > 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'sau $index bài', // chỗ này có phải check thêm điều kiện count danh sách bài tập trong collection?
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
        });
      },
      tileColor: AppColor.listTileButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: Icon(
        Icons.air_rounded,
        color: AppColor.textColor,
      ),
      title: Text(
        'Lượt nghỉ'.tr,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        'sau 2 bài'.tr,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildExerciseList(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Danh sách bài tập'.tr,
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(
          height: 4,
        ),
        ExerciseInCollectionTile(
          asset: SVGAssetString.boxing,
          title: 'Đánh lộn nè',
          description: '10 giây',
          onPressed: () {},
        ),
        const SizedBox(
          height: 4,
        ),
        ExerciseInCollectionTile(
          asset: SVGAssetString.boxing,
          title: 'Đánh lộn nè 2',
          description: '10 giây',
          onPressed: () {},
        ),
        const SizedBox(
          height: 4,
        ),
        ExerciseInCollectionTile(
          asset: SVGAssetString.boxing,
          title: 'Đánh lộn nè 3',
          description: '10 giây',
          onPressed: () {},
        ),
      ],
    );
  }

  _showSelection(context,
      {required double maxHeight,
      required Widget? Function(BuildContext, int) itemBuilder}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: maxHeight * 0.32,
          child: CupertinoPicker.builder(
            onSelectedItemChanged: (int value) {},
            backgroundColor: Colors.white,
            itemExtent: 48,
            scrollController: FixedExtentScrollController(initialItem: 1),
            itemBuilder: itemBuilder,
          ),
        );
      },
    );
  }
}

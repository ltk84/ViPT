import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/workout/widgets/custom_tile.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: null,
        title: Text(
          'Thư viện'.tr,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: ListView(
        children: [
          CustomTile(
            asset: PNGAssetString.workout_2,
            onPressed: () {},
            title: 'Bài tập',
            description: 'Tra cứu thông tin chi tiết của một bài tập cụ thể',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: PNGAssetString.workout_1,
            onPressed: () {},
            title: 'Bộ luyện tập',
            description:
                'Tra cứu các bộ sưu tập gồm nhiều bài tập để tập luyện',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: PNGAssetString.nutrition_1,
            onPressed: () {},
            title: 'Món ăn',
            description: 'Tra cứu thông tin chi tiết của một món ăn cụ thể',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: PNGAssetString.nutrition_2,
            onPressed: () {},
            title: 'Bộ dinh dưỡng',
            description: 'Tra cứu các bộ sưu tập gồm nhiều món ăn',
          ),
          const Divider(
            indent: 24,
          ),
        ],
      ),
    );
  }
}

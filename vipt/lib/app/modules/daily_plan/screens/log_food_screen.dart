import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_card.dart';
import 'package:vipt/app/modules/workout_collection/add_workout_collection_controller.dart';
import 'package:vipt/app/modules/workout_collection/widgets/search_field_widget.dart';

class LogFoodScreen extends StatelessWidget {
  LogFoodScreen({Key? key}) : super(key: key);

  final _controller = Get.find<AddWorkoutCollectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.close_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Thêm thức ăn'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).backgroundColor,
            icon: const Hero(
              tag: 'actionButtonAppBar',
              child: Icon(
                Icons.check_rounded,
                color: AppColor.secondaryColor,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: SearchFieldWidget(
                controller: _controller.searchTextController,
                textStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 16)),
          ),
          Divider(
            height: 0,
            color: AppColor.textFieldUnderlineColor,
          ),
          GetBuilder<AddWorkoutCollectionController>(
            builder: (_) => Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: _controller.searchTextController.text.isNotEmpty
                    ? _buildSearchResultListView(context, _controller)
                    : _buildInitialListView(context, _controller),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.nutriBackgroundColor,
        onPressed: () {},
        isExtended: true,
        elevation: 1,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            'Tạo món ăn mới'.tr,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: AppColor.accentTextColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _buildSearchResultListView(
    context, AddWorkoutCollectionController _controller) {
  return ListView(
    physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        alignment: Alignment.center,
        child: Obx(
          () => Text(
            'Đã chọn ${_controller.selectValueList.length} thức ăn',
            style: Theme.of(Get.context!).textTheme.subtitle1,
          ),
        ),
      ),
      ResponsiveGridRow(
        children: _controller.searchResult.map((workout) {
          return ResponsiveGridCol(
            xs: 12,
            child: Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: MultipleChoiceCard(
                  selectedColor: AppColor.nutriBackgroundColor,
                  title: workout.name,
                  subtitle: '260 kcal',
                  isSelected: _controller.selectValueList.contains(workout.id),
                  onSelected: () {
                    _controller.handleSelect(workout.id ?? '');
                  },
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildInitialListView(context, _controller) {
  return ListView(
    physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        alignment: Alignment.center,
        child: Obx(
          () => Text(
            'Đã chọn ${_controller.selectValueList.length} thức ăn',
            style: Theme.of(Get.context!).textTheme.subtitle1,
          ),
        ),
      ),
      ResponsiveGridRow(
        children: DataService.instance.workoutList.map((workout) {
          return ResponsiveGridCol(
            xs: 12,
            child: Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: MultipleChoiceCard(
                  selectedColor: AppColor.nutriBackgroundColor,
                  title: workout.name,
                  subtitle: '260 kcal',
                  isSelected: _controller.selectValueList.contains(workout.id),
                  onSelected: () {
                    _controller.handleSelect(workout.id ?? '');
                  },
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

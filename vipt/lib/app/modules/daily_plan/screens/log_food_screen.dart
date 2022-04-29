import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/nutrition.dart';
import 'package:vipt/app/global_widgets/loading_widget.dart';
import 'package:vipt/app/modules/daily_plan/local_meal_controller.dart';
import 'package:vipt/app/modules/daily_plan/screens/add_food_screen.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_card.dart';
import 'package:vipt/app/modules/workout_collection/widgets/search_field_widget.dart';

import '../daily_nutrition_controller.dart';

class LogFoodScreen extends StatelessWidget {
  LogFoodScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DailyNutritionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Builder(builder: (context) {
        DefaultTabController.of(context)!.addListener(() {
          if (DefaultTabController.of(context)!.indexIsChanging) {
            _controller.activeTabIndex.value =
                DefaultTabController.of(context)!.index;
          }
        });
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
                _controller.resetSelectedList();
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
                onPressed: () async {
                  await _controller.handleLogTrack();
                },
              ),
            ],
            bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.caption,
              tabs: const [
                Tab(
                  height: 20,
                  text: 'Mặc định',
                ),
                Tab(
                  height: 20,
                  text: 'Cá nhân',
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Obx(() => _controller.finishFetchFoodList.value
                ? _buildFoodListView(context,
                    foodList: _controller.firebaseFoodList,
                    editable: false,
                    handleSelect: _controller.handleSelect,
                    selectedList: _controller.selectedList,
                    triggerText: _controller.firebaseSearchText,
                    searchController: _controller.firebaseListSearchController,
                    searchResultList: _controller.firebaseSearchResult)
                : const LoadingWidget()),
            Obx(
              () => _buildFoodListView(
                context,
                foodList: _controller.localFoodList,
                editable: true,
                searchController: _controller.localListSearchController,
                searchResultList: _controller.localSearchResult,
                triggerText: _controller.localSearchText,
                handleSelect: _controller.handleSelect,
                selectedList: _controller.selectedList,
              ),
            ),
          ]),
          floatingActionButton: Obx(() =>
              _buildFloatingButton(context, _controller.activeTabIndex.value)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  Widget _buildFloatingButton(BuildContext context, int currentIndex) {
    if (currentIndex == 0) return Container();
    return FloatingActionButton.extended(
      backgroundColor: AppColor.nutriBackgroundColor,
      onPressed: () async {
        Get.lazyPut(() => LocalMealController());
        final result = await Get.bottomSheet(
          Container(
            margin: const EdgeInsets.only(top: 64),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: AddFoodScreen(),
            ),
          ),
          isScrollControlled: true,
        );
        Get.delete<LocalMealController>();
        if (result) {
          await _controller.fetchcLocalFoodList();
        }
      },
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
    );
  }
}

_buildFoodListView(
  context, {
  required List<Nutrition> foodList,
  required bool editable,
  required List<Nutrition> selectedList,
  required TextEditingController searchController,
  required List<Nutrition> searchResultList,
  required Rx<String> triggerText,
  required Function(Nutrition) handleSelect,
}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        child: SearchFieldWidget(
            controller: searchController,
            textStyle:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16)),
      ),
      Divider(
        height: 0,
        color: AppColor.textFieldUnderlineColor,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: triggerText.value.isEmpty
              ? _buildInitialListView(context,
                  foodList: foodList,
                  editable: editable,
                  selectedList: selectedList,
                  handleSelect: handleSelect)
              : _buildSearchResultListView(context,
                  selectedList: selectedList,
                  searchResultList: searchResultList,
                  handleSelect: handleSelect),
        ),
      ),
    ],
  );
}

Widget _buildSearchResultListView(context,
    {required List<Nutrition> selectedList,
    required List<Nutrition> searchResultList,
    required Function(Nutrition) handleSelect}) {
  return ListView(
    physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        alignment: Alignment.center,
        child: Text(
          'Đã chọn ${selectedList.length} thức ăn',
          style: Theme.of(Get.context!).textTheme.subtitle1,
        ),
      ),
      ResponsiveGridRow(
        children: searchResultList.map((nutrition) {
          return ResponsiveGridCol(
            xs: 12,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: MultipleChoiceCard(
                selectedColor: AppColor.nutriBackgroundColor,
                title: nutrition.getName(),
                subtitle: '260 kcal',
                isSelected: selectedList.contains(nutrition),
                onSelected: () {
                  handleSelect(nutrition);
                },
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildInitialListView(
  context, {
  required List<Nutrition> foodList,
  bool editable = false,
  required List<Nutrition> selectedList,
  required Function(Nutrition) handleSelect,
}) {
  return ListView(
    physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        alignment: Alignment.center,
        child: Text(
          'Đã chọn ${selectedList.length} thức ăn',
          style: Theme.of(Get.context!).textTheme.subtitle1,
        ),
      ),
      ...foodList.map((food) {
        return ResponsiveGridRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ResponsiveGridCol(
                xs: editable ? 11 : 12,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: MultipleChoiceCard(
                    selectedColor: AppColor.nutriBackgroundColor,
                    title: food.getName(),
                    subtitle: food.calories.toInt().toString() + ' kcal',
                    isSelected: selectedList.contains(food),
                    onSelected: () {
                      handleSelect(food);
                    },
                  ),
                ),
              ),
              if (editable)
                ResponsiveGridCol(
                  xs: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: AppColor.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ]);
      }).toList(),
    ],
  );
}

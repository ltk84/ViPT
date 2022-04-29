import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/global_widgets/editable_intro_collection_widget.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/modules/daily_plan/local_meal_controller.dart';
import 'package:vipt/app/modules/daily_plan/widgets/input_amount_dialog.dart';

class AddFoodScreen extends StatelessWidget {
  AddFoodScreen({Key? key}) : super(key: key);

  final _controller = Get.find<LocalMealController>();

  final TextEditingController nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      nameTextController.addListener(() {
        _controller.name = nameTextController.text;
        if (nameTextController.text.isEmpty) {
          _controller.isTextFieldValidate.value = false;
        } else {
          _controller.isTextFieldValidate.value = true;
        }
      });
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          leading: IconButton(
            icon: const Hero(
              tag: 'leadingButtonAppBar',
              child: Icon(Icons.close_rounded),
            ),
            onPressed: () {
              Get.back(result: false);
            },
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
                await _controller.addLocalMeal();
                Get.back(result: true);
              },
            ),
          ],
        ),
        body: Container(
          padding: AppDecoration.screenPadding.copyWith(top: 8, bottom: 0),
          child: LayoutBuilder(builder: (context, constraints) {
            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Obx(
                  () => EditableIntroCollectionWidget(
                    titleTextController: nameTextController,
                    hintTitle: 'Nhập tên thức ăn',
                    errorText: _controller.isTextFieldValidate.value
                        ? null
                        : 'Hãy điền tên thức ăn',
                    titleTextStyle: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: AppColor.textColor
                        .withOpacity(AppColor.disabledTextOpacity),
                  ),
                ),
                // const SizedBox(
                //   height: 16,
                // ),
                Obx(
                  () => _buildIntakeCaloriesDisplay(
                      context, _controller.calories.value),
                ),
                // const SizedBox(
                //   height: 16,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: AppColor.textColor
                        .withOpacity(AppColor.disabledTextOpacity),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => _buildNutritionFacts(context,
                    protein: _controller.protein.value,
                    carbs: _controller.carbs.value,
                    fat: _controller.fat.value)),
                const SizedBox(
                  height: 32,
                ),
                _buildGuideSection(context),
              ],
            );
          }),
        ),
      );
    });
  }

  Widget _buildNutritionFacts(context,
      {required num carbs, required num protein, required num fat}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InfoCubeWidget(
          onTap: () async {
            final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return InputAmountDialog(
                  title: 'Carbs',
                  unit: 'g',
                  value: carbs.toInt(),
                  confirmButtonColor: AppColor.carbCubeColor,
                  confirmButtonText: 'Xác nhận',
                  sliderActiveColor: AppColor.carbCubeColor,
                  sliderInactiveColor: AppColor.carbCubeColor.withOpacity(
                    AppColor.subTextOpacity,
                  ),
                );
              },
            );

            if (result != null) {
              _controller.carbs.value = result;
            }
          },
          title: '${carbs.toStringAsFixed(0)}g',
          subtitle: 'Carbs',
          color: AppColor.carbCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        const SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          onTap: () async {
            final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return InputAmountDialog(
                  title: 'Protein',
                  unit: 'g',
                  value: protein.toInt(),
                  confirmButtonColor: AppColor.proteinCubeColor,
                  confirmButtonText: 'Xác nhận',
                  sliderActiveColor: AppColor.proteinCubeColor,
                  sliderInactiveColor: AppColor.proteinCubeColor.withOpacity(
                    AppColor.subTextOpacity,
                  ),
                );
              },
            );

            if (result != null) {
              _controller.protein.value = result;
            }
          },
          title: '${protein.toStringAsFixed(0)}g',
          subtitle: 'Protein',
          color: AppColor.proteinCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        const SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          onTap: () async {
            final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return InputAmountDialog(
                  title: 'Fat',
                  unit: 'g',
                  value: fat.toInt(),
                  confirmButtonColor: AppColor.fatCubeColor,
                  confirmButtonText: 'Xác nhận',
                  sliderActiveColor: AppColor.fatCubeColor,
                  sliderInactiveColor: AppColor.fatCubeColor.withOpacity(
                    AppColor.subTextOpacity,
                  ),
                );
              },
            );

            if (result != null) {
              _controller.fat.value = result;
            }
          },
          title: '${fat.toStringAsFixed(0)}g',
          subtitle: 'Fat',
          color: AppColor.fatCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
      ],
    );
  }

  Widget _buildIntakeCaloriesDisplay(context, num amount) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return InputAmountDialog(
                title: 'Calories',
                unit: 'kcal',
                value: 1,
                confirmButtonColor: AppColor.nutriBackgroundColor,
                confirmButtonText: 'Xác nhận',
                sliderActiveColor: AppColor.nutriBackgroundColor,
                sliderInactiveColor: AppColor.nutriBackgroundColor.withOpacity(
                  AppColor.subTextOpacity,
                ),
              );
            },
          );

          if (result != null) {
            _controller.calories.value = result;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SVGAssetString.dish,
                height: 24,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calories',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '${amount.toStringAsFixed(0)} kcal',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hướng dẫn',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Chạm vào các vị trí Tên, Calories, Carbs, Protein, Fat để thay đổi giá trị tương ứng.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/daily_plan/screens/add_ingredient_to_food_screen.dart';
import 'package:vipt/app/modules/nutrition/widgets/dish_ingredients_widget.dart';

class EditableIngredientListWidget extends StatelessWidget {
  const EditableIngredientListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Danh sách nguyên liệu'.tr,
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(
          height: 4,
        ),
        ListTile(
          onTap: () {
            Get.bottomSheet(
              Container(
                margin: const EdgeInsets.only(top: 48),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: AddIngredientToFoodScreen(),
                ),
              ),
              isScrollControlled: true,
            );
          },
          horizontalTitleGap: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          leading: Icon(
            Icons.add,
            color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
          ),
          title: Text(
            'Thêm nguyên liệu'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
        ),
        Divider(
          color: AppColor.textFieldUnderlineColor,
          height: 0,
        ),
        ListTile(
          onTap: () {},
          horizontalTitleGap: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          leading: Icon(
            Icons.delete_sweep_rounded,
            color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
          ),
          title: Text(
            'Xóa hết'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
        ),
        Divider(
          color: AppColor.textFieldUnderlineColor,
          height: 0,
        ),
        const SizedBox(
          height: 24,
        ),
        const DishIngredientsWidget(
          showTitle: false,
          tileColor: AppColor.ingredientTileColor,
          enableEdittingAmount: true,
          ingredients: {
            'Khoai tây': '100g',
            'Khoai tây 1': '100g',
            'Khoai tây 2': '100g'
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';

class ChangeAmountNutritionWidget extends StatefulWidget {
  final MealNutrition nutrition;

  const ChangeAmountNutritionWidget({Key? key, required this.nutrition})
      : super(key: key);

  @override
  State<ChangeAmountNutritionWidget> createState() =>
      _ChangeAmountNutritionWidgetState();
}

class _ChangeAmountNutritionWidgetState
    extends State<ChangeAmountNutritionWidget> {
  late double _defaultValue;
  late double _value;

  @override
  void initState() {
    try {
      List<String> listAmount = (widget.nutrition as MealNutrition)
          .meal
          .ingreIDToAmount
          .values
          .toList();
      _defaultValue = 0;
      for (int i = 0; i < listAmount.length; i++) {
        listAmount[i] = listAmount[i].replaceAll(RegExp("[^\\d.]"), "");
        _defaultValue += double.parse(listAmount[i]);
      }
      _value = _defaultValue;
    } catch (e) {
      print('count ingredient amount error');
      _defaultValue = 0;
      _value = 0;
    }
    super.initState();
    print(widget.nutrition.ingredients);
  }

  @override
  Widget build(BuildContext context) {
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
            Get.back();
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
            onPressed: () {
              Get.back(result: _value);
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
                IntroCollectionWidget(
                  title: widget.nutrition.getName(),
                  description: "",
                ),
                const SizedBox(
                  height: 16,
                ),
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
                _buildIntakeCaloriesDisplay(
                  context,
                  widget.nutrition.calories * (_value / _defaultValue),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                _buildNutritionFacts(
                  context,
                  protein: widget.nutrition.protein * (_value / _defaultValue),
                  carbs: widget.nutrition.carbs * (_value / _defaultValue),
                  fat: widget.nutrition.fat * (_value / _defaultValue),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Khối lượng',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_value.toStringAsFixed(0)}g',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            setState(() {
                              _value = _defaultValue;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Text(
                              'Reset',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: AppColor.textColor
                                        .withOpacity(AppColor.subTextOpacity),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Slider(
                  value: _value.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  min: 0,
                  max: 2000,
                  activeColor: AppColor.nutriBackgroundColor,
                  inactiveColor: AppColor.nutriBackgroundColor
                      .withOpacity(AppColor.subTextOpacity),
                  thumbColor: AppColor.accentTextLightColor,
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Lướt thanh trượt để tùy chỉnh lượng thành phần',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          })),
    );
  }

  Widget _buildNutritionFacts(context,
      {required num carbs, required num protein, required num fat}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InfoCubeWidget(
          title: '${carbs.toStringAsFixed(0)}g',
          subtitle: 'Carbs',
          color: AppColor.carbCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        const SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          title: '${protein.toStringAsFixed(0)}g',
          subtitle: 'Protein',
          color: AppColor.proteinCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        const SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          title: '${fat.toStringAsFixed(0)}g',
          subtitle: 'Fat',
          color: AppColor.fatCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
      ],
    );
  }

  Widget _buildIntakeCaloriesDisplay(context, num amount) {
    return Row(
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
    );
  }
}

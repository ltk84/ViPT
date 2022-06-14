import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/data/models/tracker.dart';

abstract class Nutrition extends BaseModel {
  num calories;
  num carbs;
  num fat;
  num protein;

  Nutrition(String? id,
      {this.calories = 0, this.carbs = 0, this.protein = 0, this.fat = 0})
      : super(id);

  Tracker convertToMealNutritionTracker();
  String getName();
}

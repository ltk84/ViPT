import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/ingredient.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_category.dart';

// DEMmwUKFWFfNQYV1X4y0, UAeHr7FY4ljFpztTEJ7s, sQpE1Hjx7JN8QXTmVIhI
List<MealCategory> mealCatefakeData = [
  MealCategory.fromCategory(
      Category('', name: "Breakfast", asset: '', parentCategoryID: null)),
  MealCategory.fromCategory(
      Category('', name: "Lunch", asset: '', parentCategoryID: null)),
  MealCategory.fromCategory(
      Category('', name: "Dinner", asset: '', parentCategoryID: null)),
];

//T6hDmw8efBd71CGJ55TJ
// pJLXqyLi1H7Nq7Y2q2Dp
// 2cjdR4Rd06tgvuTnx6w9
// uwXmiyFWe0c1ePIRuWJ3
List<Ingredient> ingredientFakeData = [
  Ingredient(id: 'id', name: 'Meat', kcal: 10, fat: 10, carbs: 10, protein: 10),
  Ingredient(id: 'id', name: 'Fish', kcal: 10, fat: 10, carbs: 10, protein: 10),
  Ingredient(id: 'id', name: 'Egg', kcal: 10, fat: 10, carbs: 10, protein: 10),
  Ingredient(id: 'id', name: 'Milk', kcal: 10, fat: 10, carbs: 10, protein: 10),
];

// wCkbHDMbgqLW7P5XlICN
// 8lW31KqNyejzmrpJgxz0
// JrppFIhAinBdH8YKLSUB

List<Meal> mealFakeData = [
  Meal(
    id: 'id',
    name: 'Fried Egg',
    asset: 'asset',
    cookTime: 10,
    ingreIDToAmount: {'2cjdR4Rd06tgvuTnx6w9': '100gram'},
    steps: ['Xuan Thanh yeu Hong Van', 'Xuan Truong yeu Thien Thanh'],
    categoryIDs: ['DEMmwUKFWFfNQYV1X4y0'],
  ),
  Meal(
    id: 'id',
    name: 'Bo beefsteak - Duc Fuck',
    asset: 'asset',
    cookTime: 10,
    ingreIDToAmount: {'T6hDmw8efBd71CGJ55TJ': '100gram'},
    steps: ['Kim Lam yeu Truc Truc', 'Quy Phat yeu Minh Tuong'],
    categoryIDs: ['UAeHr7FY4ljFpztTEJ7s'],
  ),
  Meal(
    id: 'id',
    name: 'Fried Fish',
    asset: 'asset',
    cookTime: 10,
    ingreIDToAmount: {'pJLXqyLi1H7Nq7Y2q2Dp': '100gram'},
    steps: ['Miseo yeu cay keo'],
    categoryIDs: ['sQpE1Hjx7JN8QXTmVIhI'],
  ),
];
